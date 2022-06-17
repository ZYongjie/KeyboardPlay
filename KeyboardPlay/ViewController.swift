//
//  ViewController.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/5/30.
//

import Cocoa
import AVFoundation

struct PlayableKey: Equatable, Hashable {
    let original: Character
    let audioName: String
    let displayName: String
}

extension PlayableKey {
    init(original: Character) {
        self.init(original: original, audioName: .init(original), displayName: .init(original))
    }
    
    init(original: Character, others: String) {
        self.init(original: original, audioName: others, displayName: others)
    }
}

class ViewController: NSViewController {
    @IBOutlet weak var label: NSTextField!
    var player: AVAudioPlayer?
    let specialKeys: [PlayableKey] = [
         .init(original: "\t", others: "tab"),
         .init(original: "\r", others: "enter"),
         .init(original: "\u{1B}", others: "caps"),
         .init(original: " ", others: "space"),
         .init(original: "\u{7F}", others: "backspace"),
         .init(original: "\u{F700}", audioName: "up", displayName: "↑"),
         .init(original: "\u{F701}", audioName: "down", displayName: "↓"),
         .init(original: "\u{F702}", audioName: "left", displayName: "←"),
         .init(original: "\u{F703}", audioName: "right", displayName: "→"),
         // 无法已.开头命名文件名
         .init(original: ".", audioName: "period", displayName: "."),
         // 无法匹配到/命名的文件
         .init(original: "/", audioName: "slash", displayName: "/"),
         // 中文字符
         .init(original: "·", others: "`"),
         .init(original: "【", others: "["),
         .init(original: "】", others: "]"),
         .init(original: "、", others: "\\"),
         .init(original: "；", others: ";"),
         .init(original: "‘", others: "'"),
         .init(original: "，", others: ","),
         .init(original: "。", audioName: "period", displayName: "."),
         .init(original: "/", audioName: "slash", displayName: "/"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
//            print(event )
//        }
        
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            self.handleKeyDown(event: event)
            return nil
        }
        
        var lastModifierFlags: NSEvent.ModifierFlags?
        NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { event in
            let modifierKeys: [NSEvent.ModifierFlags] = [.shift, .control, .command, .option]
            
            print("flagsChanged", event )
            var flags = event.modifierFlags
            if let last = lastModifierFlags {
                flags = flags.subtracting(last)
            }
            print("is command", flags.isSuperset(of: .command))
            print("is ctrl", flags.isSuperset(of: .control))
            
            lastModifierFlags = event.modifierFlags
            return nil
        }
    }
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    private func handleKeyDown(event: NSEvent) {
        guard let char = event.characters?.first else { return }
        let playItem = specialKeys.first(where: { $0.original == char }) ?? .init(original: char)
        play(item: playItem)
    }

    private func play(item: PlayableKey) {
        print("keyDown:", item.original)
        player?.stop()
        let bundle = Bundle.main
        if let url = bundle.url(forResource: item.audioName, withExtension: "wav")
            ?? bundle.url(forResource: item.audioName, withExtension: "mp3"){
            do {
                
                player = try AVAudioPlayer(contentsOf: url)
                player?.prepareToPlay()
                player?.play()
                label.stringValue = item.displayName.capitalized
            } catch let error {
                print("error", error)
            }
        }
    }
}

