//
//  SymbolSource.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/7/11.
//

import Foundation

struct SymbolSource: PlayItem {
    let char: Character
    
    var event: PlayItemGenerator.Event {
        .otherKeyDown(char)
    }
    
    var type: MediaType
    
    var audioName: String
    
    var displayName: String
    
    var imageName: String?
    
    
}

extension SymbolSource {
    static var all: [SymbolSource] {
        [
            .init(audio: "`"),
            .init(char: "~", type: .audio, audioName: "tilde", displayName: "~"),
            .init(audio: "!"),
            .init(audio: "@"),
            .init(audio: "#"),
            .init(audio: "$"),
            .init(audio: "%"),
            .init(audio: "^"),
            .init(audio: "&"),
            .init(audio: "*"),
            .init(audio: "("),
            .init(audio: ")"),
            .init(audio: "-"),
            .init(audio: "_"),
            .init(audio: "="),
            .init(audio: "+"),
            .init(audio: "["),
            .init(audio: "{"),
            .init(audio: "]"),
            .init(audio: "}"),
            .init(audio: "\\"),
            .init(audio: "|"),
            .init(audio: ";"),
            .init(char: ":", type: .audio, audioName: "colon", displayName: ":"),
            .init(audio: "'"),
            .init(audio: "\""),
            .init(audio: ","),
            .init(audio: "<"),
            .init(char: ".", type: .audio, audioName: "period", displayName: "."),
            .init(audio: ">"),
            .init(char: "/", type: .audio, audioName: "slash", displayName: "/"),
            .init(audio: "?"),
        ]
    }
    
    init(audio withChar: Character) {
        self.init(char: withChar, type: .audio, audioName: .init(withChar), displayName: .init(withChar))
    }
}
