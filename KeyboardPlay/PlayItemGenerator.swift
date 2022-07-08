//
//  PlayItemGenerator.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/6/23.
//

import Foundation
import AppKit

protocol PlayItem: Playable, Displayable {
    var event: PlayItemGenerator.Event { get }
}

class PlayItemGenerator {
    enum State {
        case ideal, play(Event, PlayItem, Int), noSource(Event)
        
        var playItem: PlayItem? {
            switch self {
            case let .play(_, item, _):
                return item
            case .noSource(_):
                return UnknownSource()
            default:
                return nil
            }
        }
    }
    
    enum Event: Equatable, Comparable {
        case unknown    //未知事件，产生unknown事件时，state不会变为ideal
        case ignore     //忽略事件，不进行状态转化
        case alphabetKeyDown(Character)
        case number(Character)
        case modifierKeyDown(NSEvent.ModifierFlags)
        case specialKeyDown(NSEvent.SpecialKey)
        case otherKeyDown(Character)
        
        enum HashType: String {
            case unknown, ignore, alphabetKeyDown, number, modifierKeyDown, specialKeyDown, otherKeyDown
        }
        var hashValue: HashType {
            switch self {
            case .unknown:
                return .unknown
            case .ignore:
                return .ignore
            case .alphabetKeyDown(_):
                return .alphabetKeyDown
            case .number(_):
                return .number
            case .modifierKeyDown(_):
                return .modifierKeyDown
            case .specialKeyDown(_):
                return .specialKeyDown
            case .otherKeyDown(_):
                return .otherKeyDown
            }
        }
        
        static func < (lhs: PlayItemGenerator.Event, rhs: PlayItemGenerator.Event) -> Bool {
            guard lhs.hashValue == rhs.hashValue else {
                return lhs.hashValue.rawValue < rhs.hashValue.rawValue
            }
            
            if case let .alphabetKeyDown(lchar) = lhs, case let .alphabetKeyDown(rchar) = rhs {
                return lchar < rchar
            }
            if case let .number(lchar) = lhs, case let .number(rchar) = rhs {
                return lchar < rchar
            }
            if case let .modifierKeyDown(lflag) = lhs, case let .modifierKeyDown(rflag) = rhs {
                return lflag.rawValue < rflag.rawValue
            }
            if case let .specialKeyDown(lflag) = lhs, case let .specialKeyDown(rflag) = rhs {
                return lflag.rawValue < rflag.rawValue
            }
            if case let .otherKeyDown(lchar) = lhs, case let .otherKeyDown(rchar) = rhs {
                return lchar < rchar
            }
            
            return false
        }
    }
    
    let sourceItems: [Event.HashType: [PlayItem]] = PlayItemGenerator.sources()
    var maxCacheEventCount = 100
    var eventCache = [NSEvent]()
    var state = State.ideal
    
    func receive(event: NSEvent) -> PlayItem? {
        cache(event: event)
        
        let _event = adapter(event: event)
        
        guard .ignore != _event else {
            return nil
        }
        
        state = getNextState(with: _event, currentState: state)
        return state.playItem
    }
    
    private func adapter(event: NSEvent) -> Event {
        switch event.type {
        case .keyDown:
            guard let specialKey = event.specialKey else {
                guard let char = event.characters?.first else { return .unknown }
                guard char.isLetter else {
                    guard char.isNumber else {
                        return .otherKeyDown(char)
                    }
                    return .number(char)
                }
                
                return .alphabetKeyDown(char)
            }
            return .specialKeyDown(specialKey)
        case .flagsChanged:
            let flags = event.modifierFlags
            switch event.keyCode {
            case 54,55:
                return flags.isSuperset(of: .command) ? .modifierKeyDown(.command) : .ignore
            case 61,58:
                return flags.isSuperset(of: .option) ? .modifierKeyDown(.option) : .ignore
            case 59,62:
                return flags.isSuperset(of: .control) ? .modifierKeyDown(.control) : .ignore
            case 56,60:
                return flags.isSuperset(of: .shift) ? .modifierKeyDown(.shift) : .ignore
            default:
                return .unknown
            }
        default:
            return .unknown
        }
    }
    
    private func getNextState(with event: Event, currentState: State) -> State {
        guard let sources = sourceItems[event.hashValue] else { return .noSource(event) }
        
        switch currentState {
        case .ideal, .noSource(_):
            guard let first = sources.first(where: { $0.event == event }) else { return .noSource(event) }
            return .play(event, first, 0)
        case let .play(lastEvent, _, lastIndex):
            let index = lastEvent.hashValue == event.hashValue ? lastIndex : 0
            guard let nextIndex = sources[index+1..<sources.count].firstIndex(where: { item in
                item.event == event
            }) else {
                guard let previousIndex = sources[0...index].firstIndex(where: { item in
                    item.event == event
                }) else {
                    return .noSource(event)
                }
                return .play(event, sources[previousIndex], previousIndex)
            }
            return .play(event, sources[nextIndex], nextIndex)
        }
    }
    
    private func cache(event: NSEvent) {
        eventCache.append(event)
        if eventCache.count > maxCacheEventCount {
            eventCache.removeFirst(eventCache.count - maxCacheEventCount)
        }
    }
}

extension PlayItemGenerator {
    class func sources() -> [Event.HashType: [PlayItem]] {
        [
            Event.HashType.unknown: [UnknownSource()],
            Event.HashType.alphabetKeyDown: groupSourcesByEvent(AlphabetSource.all + FruitSource.all),
            Event.HashType.number: NumberSource.all,
            Event.HashType.modifierKeyDown: ModifierSource.all,
            Event.HashType.specialKeyDown: SpecialSource.all,
            Event.HashType.otherKeyDown: OtherSource.all,
        ]
    }
    
    class func groupSourcesByEvent(_ sources: [PlayItem]) -> [PlayItem] {
        sources.sorted { item0, item1 in
            item0.event < item1.event
        }
    }
}
