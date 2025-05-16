//
//  ContentView.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 08/05/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
            JourneyView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Journey")
                }
            QuizView()
                .tabItem {
                    Image(systemName: "brain.head.profile")
                    Text("Match Me")
                }
        }
        .accentColor(colorScheme == .light ? Color("Blue_00b4d8") : Color("Blue_0077b6"))
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
//                MusicPlayerComponent.shared.startBackgroundMusic(musicTitle: "WeGoTogether", volume: 1)
//            }
//        }
        .onDisappear {
            MusicPlayerComponent.shared.stopBackgroundMusic()
        }
    }
}

#Preview {
    ContentView()
}
