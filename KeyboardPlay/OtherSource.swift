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
    
    var audioName: String
    
    var displayName: String
    
    var imageName: String?
}

extension OtherSource {
    init(_ char: Character) {
        self.init(char: char, audioName: .init(char), displayName: .init(char))
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
                return .init(char: "\u{1B}", audioName: "caps", displayName: "caps")
            case .space:
                return .init(char: " ", audioName: "space", displayName: "space")
            case .backquote:
                return .init("`")
            case .subtraction:
                return .init("-")
            case .equal:
                return .init("=")
            case .leftSquareBracket:
                return .init("[")
            case .rightSquareBracket:
                return .init("]")
            case .semicolon:
                return .init(";")
            case .quotationMark:
                return .init("'")
            case .comma:
                return .init(",")
            case .period:
                // 无法已.开头命名文件名
                return .init(char: ".", audioName: "period", displayName: ".")
            case .slash:
                // 无法匹配到/命名的文件
                return .init(char: "/", audioName: "slash", displayName: "/")
            case .backSlash:
                return .init("\\")
            }
        }
    }
}
