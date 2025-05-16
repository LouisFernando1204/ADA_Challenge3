//
//  VideoPlayerComponent.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 09/05/25.
//

import SwiftUI
import AVKit

struct VideoPlayerComponent: View {
    
    @StateObject private var playerWrapper: AVPlayerWrapper
    @Binding var stopVideo: Bool
    @State private var isPlaying: Bool = false
    
    init(videoURL: URL, stopVideo: Binding<Bool>? = nil) {
        _playerWrapper = StateObject(wrappedValue: AVPlayerWrapper(url: videoURL))
        if let stopVideo = stopVideo {
            self._stopVideo = stopVideo
        } else {
            self._stopVideo = .constant(false)
        }
    }
    
    class AVPlayerWrapper: ObservableObject {
        let player: AVPlayer
        
        init(url: URL) {
            self.player = AVPlayer(url: url)
        }
        
        func play() {
            player.play()
        }
        
        func pause() {
            player.pause()
        }
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            VideoPlayer(player: playerWrapper.player)
                .frame(height: 210)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            if !isPlaying {
                Button(action: {
                    playerWrapper.play()
                    isPlaying = true
                }) {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                }
            }
        }
        .onDisappear {
            playerWrapper.pause()
            isPlaying = false
        }
        .onChange(of: stopVideo) { _, newValue in
            if newValue {
                playerWrapper.pause()
                isPlaying = false
            }
        }
    }
}
