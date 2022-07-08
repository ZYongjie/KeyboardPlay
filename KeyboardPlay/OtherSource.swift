//
//  OtherSource.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/6/28.
//

import Foundation

struct OtherSource: PlayItem {
    let char: Character
    
    var event: PlayItemGenerator.Event {
        .otherKeyDown(char)
    }
    
    var type: MediaType
    
    var audioName: String
    
    var displayName: String
    
    var imageName: String?
}

extension OtherSource {
    init(audio withChar: Character) {
        self.init(char: withChar, type: .audio, audioName: .init(withChar), displayName: .init(withChar))
    }
    
    static var all: [OtherSource] {
        Item.allCases.map({ $0.source })
    }
    
    enum Item: CaseIterable {
        case caps
        case space
        case backquote
        case subtraction
        case equal
        case leftSquareBracket
        case rightSquareBracket
        case semicolon
        case quotationMark
        case comma
        case period
        case slash
        case backSlash
        
        var source: OtherSource {
            switch self {
            case .caps:
                return .init(char: "\u{1B}", type: .audio, audioName: "caps", displayName: "caps")
            case .space:
                return .init(char: " ", type: .audio, audioName: "space", displayName: "space")
            case .backquote:
                return .init(audio: "`")
            case .subtraction:
                return .init(audio: "-")
            case .equal:
                return .init(audio: "=")
            case .leftSquareBracket:
                return .init(audio: "[")
            case .rightSquareBracket:
                return .init(audio: "]")
            case .semicolon:
                return .init(audio: ";")
            case .quotationMark:
                return .init(audio: "'")
            case .comma:
                return .init(audio: ",")
            case .period:
                // 无法已.开头命名文件名
                return .init(char: ".", type: .audio, audioName: "period", displayName: ".")
            case .slash:
                // 无法匹配到/命名的文件
                return .init(char: "/", type: .audio, audioName: "slash", displayName: "/")
            case .backSlash:
                return .init(audio: "\\")
            }
        }
    }
}
