//
//  NumberSource.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/6/28.
//

import Foundation

struct NumberSource: PlayItem {
    let char: Character
    
    var event: PlayItemGenerator.Event {
        .number(char)
    }
    var audioName: String {
        .init(char)
    }
    
    var displayName: String {
        .init(char)
    }
    
    var imageName: String? {
        .init(char)
    }
}

extension NumberSource {
    static var all: [NumberSource] {
        (0...9).compactMap({ "\($0)".first })
            .map({ .init(char: $0) })
    }
}
