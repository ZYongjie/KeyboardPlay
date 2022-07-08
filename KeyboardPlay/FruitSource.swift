//
//  FruitSource.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/6/24.
//

import Foundation

struct FruitSource: PlayItem {
    var type: MediaType
    
    var event: PlayItemGenerator.Event
    
    var audioName: String
    
    var displayName: String
    
    var imageName: String?
}

extension FruitSource {
    init(audio withEvent: PlayItemGenerator.Event, fruit: String) {
        self.init(type: .audio, event: withEvent, audioName: fruit, displayName: fruit, imageName: fruit)
    }
    static var all: [FruitSource] {
        [
            .init(audio: .alphabetKeyDown("a"), fruit: "apple"),
            .init(type: .video, event: .alphabetKeyDown("a"), audioName: "launchVideo", displayName: "video"),
            .init(audio: .alphabetKeyDown("b"), fruit: "banana"),
            .init(audio: .alphabetKeyDown("c"), fruit: "cherry"),
            .init(audio: .alphabetKeyDown("d"), fruit: "durian"),
            .init(audio: .alphabetKeyDown("e"), fruit: "eggplant"),
            .init(audio: .alphabetKeyDown("f"), fruit: "fig"),
            .init(audio: .alphabetKeyDown("g"), fruit: "grape"),
            .init(audio: .alphabetKeyDown("h"), fruit: "haw"),
            .init(audio: .alphabetKeyDown("k"), fruit: "kiwifruit"),
            .init(audio: .alphabetKeyDown("l"), fruit: "lichee"),
            .init(audio: .alphabetKeyDown("m"), fruit: "mango"),
            .init(audio: .alphabetKeyDown("n"), fruit: "nectarine"),
            .init(audio: .alphabetKeyDown("o"), fruit: "orange"),
            .init(audio: .alphabetKeyDown("p"), fruit: "pear"),
            .init(audio: .alphabetKeyDown("r"), fruit: "rambutan"),
            .init(audio: .alphabetKeyDown("s"), fruit: "strawberry"),
            .init(audio: .alphabetKeyDown("t"), fruit: "tangerine"),
            .init(audio: .alphabetKeyDown("w"), fruit: "watermelon"),
        ]
    }
}
