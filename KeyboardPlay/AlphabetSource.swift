//
//  AlphabetSource.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/6/24.
//

import Foundation

struct AlphabetSource: PlayItem {
    var type: MediaType
    
    let char: Character
    
    var event: PlayItemGenerator.Event {
        .alphabetKeyDown(char)
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

extension AlphabetSource {
    static var all: [AlphabetSource] {
        (97...122).compactMap({ Character(UnicodeScalar($0)) })
            .map({ .init(type: .audio, char: $0) })
    }
}
