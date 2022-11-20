//
//  ViewController.swift
//  KeyboardPlay
//
//  Created by yongjie on 2022/5/30.
//

import Cocoa
import AVFoundation

protocol Playable {
    var type: MediaType { get }
    var name: String { get }
    var fileExtension: String { get }
}

extension Playable {
    var fileExtension: String {
        switch type {
        case .audio:
            return "mp3"
        case .video:
            return "mp4"
        }
    }
}

protocol Displayable {
    var displayName: String { get }
    var name: String? { get }
}

struct Audio: Playable {
    var type: MediaType
    var name: String
}

struct Video: Playable {
    var type: MediaType
    var name: String
}

struct Image {
    var name: String
}

class ViewController: NSViewController {
    @IBOutlet weak var image: NSImageView!
    @IBOutlet weak var label: NSTextField!
    lazy var generator = PlayItemGenerator()
    
    var audioPlayer: AVAudioPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    var videoPlayer: AVPlayer?
    
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
        audioPlayer?.stop()
        videoPlayer?.pause()
        videoPlayerLayer?.removeFromSuperlayer()
        
        let bundle = Bundle.main
        if let url = bundle.url(forResource: item.audioName, withExtension: item.fileExtension) {
            do {
                switch item.type {
                case .audio:
                    try playAudio(url: url)
                case .video:
                    try playVideo(url: url)
                }
            } catch let error {
                print("error", error)
            }
        }
    }
    
    private func playAudio(url: URL) throws {
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
    }
    
    private func playVideo(url: URL) throws {
        videoPlayer = AVPlayer(url: url)
        videoPlayer?.play()
        let playerLayer = AVPlayerLayer(player: videoPlayer)
        playerLayer.frame = image.bounds
        image.layer?.insertSublayer(playerLayer, at: 0)
        videoPlayerLayer = playerLayer
    }
    
    private func display(item: Displayable) {
        label.stringValue = item.displayName
        image.image = .init(named: item.imageName ?? "")
    }
}

