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
        
        var source: OtherSource {
            switch self {
            case .caps:
                return .init(char: "\u{1B}", type: .audio, audioName: "caps", displayName: "caps")
            case .space:
                return .init(char: " ", type: .audio, audioName: "space", displayName: "space")
            }
        }
    }
}
