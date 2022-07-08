//
//  SpecialSource.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/6/28.
//

import Foundation
import AppKit

struct SpecialSource: PlayItem {
    var type: MediaType
    
    let special: NSEvent.SpecialKey
    
    var event: PlayItemGenerator.Event {
        .specialKeyDown(special)
    }
    
    var audioName: String
    
    var displayName: String
    
    var imageName: String?
}

extension SpecialSource {
    init(audio withSpecial: NSEvent.SpecialKey, audioName: String) {
        self.init(type: .audio, special: withSpecial, audioName: audioName, displayName: audioName)
    }
    
    init(audio withSpecial: NSEvent.SpecialKey, audioName: String, displayName: String) {
        self.init(type: .audio, special: withSpecial, audioName: audioName, displayName: displayName)
    }
    
    static var all: [SpecialSource] {
        [
            .init(audio: .tab, audioName: "tab"),
            .init(audio: .carriageReturn, audioName: "enter"),
            .init(audio: .delete, audioName: "backspace"),
            .init(audio: .init(rawValue: 63302), audioName: "insert"),
            .init(audio: .home, audioName: "home"),
            .init(audio: .pageUp, audioName: "pageup", displayName: "page up"),
            .init(audio: .deleteForward, audioName: "delete"),
            .init(audio: .end, audioName: "end"),
            .init(audio: .pageDown, audioName: "pagedown", displayName: "page down"),
            .init(audio: .upArrow, audioName: "up", displayName: "↑"),
            .init(audio: .downArrow, audioName: "down", displayName: "↓"),
            .init(audio: .leftArrow, audioName: "left", displayName: "←"),
            .init(audio: .rightArrow, audioName: "right", displayName: "→"),
        ]
    }
}
