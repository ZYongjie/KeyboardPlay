//
//  ModifierSource.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/6/28.
//

import Foundation
import AppKit

struct ModifierSource: PlayItem {
    let flag: NSEvent.ModifierFlags
    
    var event: PlayItemGenerator.Event {
        .modifierKeyDown(flag)
    }
    
    var audioName: String {
        switch flag {
        case .command:
            return "alter"
        case .option:
            return "win"
        case .control:
            return "control"
        case .shift:
            return "shift"
        default:
            return ""
        }
    }
    
    var displayName: String {
        audioName
    }
    
    var imageName: String?
}

extension ModifierSource {
    static var all: [ModifierSource] {
        [
            .init(flag: .command, imageName: "alter"),
            .init(flag: .option, imageName: "win"),
            .init(flag: .control, imageName: "control"),
            .init(flag: .shift, imageName: "shift"),
        ]
    }
}
