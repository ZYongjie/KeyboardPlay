//
//  ViewController.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/5/30.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {
    @IBOutlet weak var label: NSTextField!
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
//            print(event )
//        }
        
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            self.handleKeyDown(event: event)
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
        play(name: .init(char))
    }

    private func play(name: String) {
        player?.stop()
        if let url = Bundle.main.url(forResource: name, withExtension: "wav") {
            do {
                
                player = try AVAudioPlayer(contentsOf: url)
                player?.prepareToPlay()
                player?.play()
                label.stringValue = name.uppercased()
            } catch let error {
                print("error", error)
            }
        }
    }
}

