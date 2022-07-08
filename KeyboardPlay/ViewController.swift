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

class ViewController: NSViewController {
    @IBOutlet weak var image: NSImageView!
    @IBOutlet weak var label: NSTextField!
    lazy var generator = PlayItemGenerator()
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            self.handleKeyDown(event: event)
            return nil
        }
        
        NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { event in
            self.handleflagsChanged(event: event)
            return nil
        }
        
    }

    var lastCharacter: Character?
    var isLastFruit = false
    private func handleKeyDown(event: NSEvent) {
        handle(event: event)
    }
    
    private var lastModifierFlags: NSEvent.ModifierFlags?
    private func handleflagsChanged(event: NSEvent) {
        handle(event: event)
    }
    
    private func handle(event: NSEvent) {
        guard let playItem = generator.receive(event: event) else { return }
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

