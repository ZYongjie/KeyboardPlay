//
//  ModifierSource.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/6/28.
//

import Foundation
import AppKit

struct ModifierSource: PlayItem {
    var type: MediaType
    
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
            .init(type: .audio, flag: .command, imageName: "alter"),
            .init(type: .audio, flag: .option, imageName: "win"),
            .init(type: .audio, flag: .control, imageName: "control"),
            .init(type: .audio, flag: .shift, imageName: "shift"),
        ]
    }
}
