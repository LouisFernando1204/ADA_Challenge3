//
//  MusicPlayerComponent.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 09/05/25.
//

import AVFoundation

class MusicPlayerComponent {
    static let shared = MusicPlayerComponent()
    var audioPlayer: AVAudioPlayer?
    var shouldPlay: Bool = true
    private(set) var isMusicStarted: Bool = false
    
    func startBackgroundMusic(musicTitle: String, volume: Float = 1.0) {
        guard shouldPlay else { return }
        guard !isMusicStarted else { return }
        
        if let bundle = Bundle.main.path(forResource: musicTitle, ofType: "mp3") {
            let musicURL = URL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: musicURL)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.volume = volume
                audioPlayer?.play()
                isMusicStarted = true
            } catch {
                print("Error playing music: \(error.localizedDescription)")
            }
        }
    }
    
    func stopBackgroundMusic() {
        audioPlayer?.stop()
        isMusicStarted = false
        shouldPlay = false
    }
    
    func setVolume(volume: Float) {
        audioPlayer?.volume = volume
    }
}
