//
//  FruitSource.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/6/24.
//

import Foundation

struct FruitSource: PlayItem {
    var event: PlayItemGenerator.Event
    
    var audioName: String
    
    var displayName: String
    
    var imageName: String?
}

extension FruitSource {
    init(event: PlayItemGenerator.Event, fruit: String) {
        self.init(event: event, audioName: fruit, displayName: fruit, imageName: fruit)
    }
    static var all: [FruitSource] {
        [
            .init(event: .alphabetKeyDown("a"), fruit: "apple"),
            .init(event: .alphabetKeyDown("b"), fruit: "banana"),
            .init(event: .alphabetKeyDown("c"), fruit: "cherry"),
            .init(event: .alphabetKeyDown("d"), fruit: "durian"),
            .init(event: .alphabetKeyDown("e"), fruit: "eggplant"),
            .init(event: .alphabetKeyDown("f"), fruit: "fig"),
            .init(event: .alphabetKeyDown("g"), fruit: "grape"),
            .init(event: .alphabetKeyDown("h"), fruit: "haw"),
            .init(event: .alphabetKeyDown("k"), fruit: "kiwifruit"),
            .init(event: .alphabetKeyDown("l"), fruit: "lichee"),
            .init(event: .alphabetKeyDown("m"), fruit: "mango"),
            .init(event: .alphabetKeyDown("n"), fruit: "nectarine"),
            .init(event: .alphabetKeyDown("o"), fruit: "orange"),
            .init(event: .alphabetKeyDown("p"), fruit: "pear"),
            .init(event: .alphabetKeyDown("r"), fruit: "rambutan"),
            .init(event: .alphabetKeyDown("s"), fruit: "strawberry"),
            .init(event: .alphabetKeyDown("t"), fruit: "tangerine"),
            .init(event: .alphabetKeyDown("w"), fruit: "watermelon"),
        ]
    }
}
