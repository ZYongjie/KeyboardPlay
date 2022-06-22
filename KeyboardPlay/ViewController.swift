//
//  ViewController.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/5/30.
//

import Cocoa
import AVFoundation

protocol Playable {
    var audioName: String { get }
}

protocol Displayable {
    var displayName: String { get }
    var imageName: String? { get }
}

struct PlayableKey: Equatable, Hashable, Playable, Displayable {
    let original: Character
    let audioName: String
    let displayName: String
    let imageName: String? = nil
}

extension PlayableKey {
    init(original: Character) {
        self.init(original: original, audioName: .init(original), displayName: .init(original))
    }
    
    init(original: Character, others: String) {
        self.init(original: original, audioName: others, displayName: others)
    }
}

struct PlayableModifierKey: Playable, Displayable {
    let original: NSEvent.ModifierFlags
    let audioName: String
    let displayName: String
    let imageName: String? = nil
}

extension PlayableModifierKey {
    init(original: NSEvent.ModifierFlags, others: String) {
        self.init(original: original, audioName: others, displayName: others)
    }
}

struct FruitKey: Playable, Displayable {
    let original: Character
    let audioName: String
    let displayName: String
    let imageName: String?
}

extension FruitKey {
    init(original: Character, others: String) {
        self.init(original: original, audioName: others, displayName: others, imageName: others)
    }
}

class ViewController: NSViewController {
    @IBOutlet weak var image: NSImageView!
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
//
         .init(original: "\u{F746}", others: "insert"),
         .init(original: "\u{F729}", others: "home"),
         .init(original: "\u{F72C}", audioName: "pageup", displayName: "page up"),
         .init(original: "\u{F728}", others: "delete"),
         .init(original: "\u{F72B}", others: "end"),
         .init(original: "\u{F72D}", audioName: "pagedown", displayName: "page down"),
    ]
    
    let modifierKeys: [PlayableModifierKey] = [
        .init(original: .command, others: "alter"),
        .init(original: .option, others: "win"),
        .init(original: .control, others: "control"),
        .init(original: .shift, others: "shift")
    ]
    
    let fruits: [FruitKey] = [
        .init(original: "a", others: "apple"),
        .init(original: "b", others: "banana"),
        .init(original: "c", others: "cherry"),
        .init(original: "d", others: "durian"),
        .init(original: "e", others: "eggplant"),
        .init(original: "f", others: "fig"),
        .init(original: "g", others: "grape"),
        .init(original: "h", others: "haw"),
        .init(original: "k", others: "kiwifruit"),
        .init(original: "l", others: "lichee"),
        .init(original: "m", others: "mango"),
        .init(original: "n", others: "nectarine"),
        .init(original: "o", others: "orange"),
        .init(original: "p", others: "pear"),
        .init(original: "r", others: "rambutan"),
        .init(original: "s", others: "strawberry"),
        .init(original: "t", others: "tangerine"),
        .init(original: "w", others: "watermelon"),
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
        
        NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { event in
            self.handleflagsChanged(event: event)
            return nil
        }
        
    }
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    var lastCharacter: Character?
    var isLastFruit = false
    private func handleKeyDown(event: NSEvent) {
        guard let char = event.characters?.first else { return }
        
        let tryFruit = lastCharacter == char && !isLastFruit
        
        lastCharacter = char
        guard tryFruit,
              let fruit = fruits.first(where: { $0.original == char }) else {
            isLastFruit = false
            let playItem = specialKeys.first(where: { $0.original == char }) ?? .init(original: char)
            play(item: playItem)
            display(item: playItem)
            return
        }
        
        isLastFruit = true
        play(item: fruit)
        display(item: fruit)
    }
    
    private var lastModifierFlags: NSEvent.ModifierFlags?
    private func handleflagsChanged(event: NSEvent) {
        var flags = event.modifierFlags
        if let last = lastModifierFlags {
            flags = flags.subtracting(last)
        }
        let playItem = self.modifierKeys.first { element in
            flags.isSuperset(of: element.original)
        }
        
        lastModifierFlags = event.modifierFlags
        
        guard let playItem = playItem else { return }
        
        play(item: playItem)
        display(item: playItem)
    }

    private func play(item: Playable) {
        player?.stop()
        let bundle = Bundle.main
        if let url = bundle.url(forResource: item.audioName, withExtension: "wav")
            ?? bundle.url(forResource: item.audioName, withExtension: "mp3"){
            do {
                
                player = try AVAudioPlayer(contentsOf: url)
                player?.prepareToPlay()
                player?.play()
            } catch let error {
                print("error", error)
            }
        }
    }
    
    private func display(item: Displayable) {
        label.stringValue = item.displayName.capitalized
        image.image = .init(named: item.imageName ?? "")
    }
}

