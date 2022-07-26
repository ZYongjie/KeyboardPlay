//
//  CarSource.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/7/11.
//

import Foundation

struct CarSource: PlayItem {
    var type: MediaType
    
    var event: PlayItemGenerator.Event
    
    var audioName: String
    
    var displayName: String
    
    var imageName: String?
}

extension CarSource {
    init(name: String) {
        self.init(type: .audio, event: .alphabetKeyDown(name.first!), audioName: name, displayName: name, imageName: name)
    }
    static var all: [CarSource] {
        [
            .init(name: "ambulance"),
            .init(name: "bulldozer"),
            .init(name: "concrete mixer"),
            .init(name: "dump truck"),
            .init(name: "excavator"),
            .init(name: "fire engine"),
            .init(name: "garbage truck"),
            .init(name: "pickup truck"),
            .init(name: "school bus"),
            .init(name: "tank truck"),
            .init(name: "tow truck"),
            .init(name: "airplane"),
            .init(name: "bicycle"),
            .init(name: "boat"),
            .init(name: "bus"),
            .init(name: "metro"),
            .init(name: "ship"),
            .init(name: "taxi"),
            .init(name: "train"),
            
            
            .init(name: "air conditioning"),
            .init(name: "bed"),
            .init(name: "cup"),
            .init(name: "door"),
            .init(name: "sofa"),
            .init(name: "table"),
            .init(name: "table lamp"),
        ]
    }
}
