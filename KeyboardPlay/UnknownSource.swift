//
//  UnknownSource.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/6/28.
//

import Foundation

struct UnknownSource: PlayItem {
    let event: PlayItemGenerator.Event = .unknown
    
    let audioName: String = "encounterError"
    
    let displayName: String = "encounter error"
    
    var imageName: String?
}
