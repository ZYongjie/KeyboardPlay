//
//  SpecialSource.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/6/28.
//

import Foundation
import AppKit

struct SpecialSource: PlayItem {
    let special: NSEvent.SpecialKey
    
    var event: PlayItemGenerator.Event {
        .specialKeyDown(special)
    }
    
    var audioName: String
    
    var displayName: String
    
    var imageName: String?
}

extension SpecialSource {
    init(special: NSEvent.SpecialKey, audioName: String) {
        self.init(special: special, audioName: audioName, displayName: audioName)
    }
    
    static var all: [SpecialSource] {
        [
            .init(special: .tab, audioName: "tab"),
            .init(special: .carriageReturn, audioName: "enter"),
            .init(special: .delete, audioName: "backspace"),
            .init(special: .init(rawValue: 63302), audioName: "insert"),
            .init(special: .home, audioName: "home"),
            .init(special: .pageUp, audioName: "pageup", displayName: "page up"),
            .init(special: .deleteForward, audioName: "delete"),
            .init(special: .end, audioName: "end"),
            .init(special: .pageDown, audioName: "pagedown", displayName: "page down"),
            .init(special: .upArrow, audioName: "up", displayName: "↑"),
            .init(special: .downArrow, audioName: "down", displayName: "↓"),
            .init(special: .leftArrow, audioName: "left", displayName: "←"),
            .init(special: .rightArrow, audioName: "right", displayName: "→"),
        ]
    }
}
