//
//  AlphabetSource.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/6/24.
//

import Foundation

struct AlphabetSource: PlayItemSource {
    var audio: Playable? {
        Audio(type: .audio, audioName: char.lowercased())
    }
    
    var display: Displayable? {
        
    }
    
    var next: PlayItemSource?
    
    var type: MediaType
    
    let char: Character
    
    var event: PlayItemGenerator.Event {
        .alphabetKeyDown(char)
    }
    var audioName: String {
        char.lowercased()
    }
    
    var displayName: String {
        .init(char)
    }
    
    var imageName: String? {
        .init(char)
    }
    
    var fileExtension: String {
        "wav"
    }
}

extension AlphabetSource {
    static var all: [AlphabetSource] {
        (97...122).compactMap({ Character(UnicodeScalar($0)) })
            .reduce([AlphabetSource](), { partialResult, char in
                return partialResult + [
                    .init(type: .audio, char: char),
                    .init(type: .audio, char: char.uppercased().first!)
                ]
            })
    }
}
