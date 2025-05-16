//
//  SettingModalComponent.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 15/05/25.
//

import SwiftUI

struct SettingModalComponent: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    private var screenWidth = ScreenSizeComponent().screenWidth
    private var screenHeight = ScreenSizeComponent().screenHeight
    
    @State private var isMusicOn: Bool = MusicPlayerComponent.shared.shouldPlay
    
    var body: some View {
        self.setUpSettingModal(isMusicOn: self.isMusicOn, screenWidth: self.screenWidth, screenHeight: self.screenHeight)
    }
    
    private func setUpSettingModal(isMusicOn: Bool, screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .center, spacing: 18) {
                    self.header()
                    self.toggleButton(isMusicOn: $isMusicOn)
                }
                .padding(16)
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            dismiss()
                        }
                        .foregroundColor(colorScheme == .light ? Color("Blue_00b4d8") : Color("Blue_0077b6"))
                    }
                }
            }
        }
    }
    
    private func header() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Background Music")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Color(.label))
                .multilineTextAlignment(.leading)
            Text("Enable or disable background music in the app as you prefer.")
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func toggleButton(isMusicOn: Binding<Bool>) -> some View {
        Toggle(isOn: $isMusicOn) {
            Text(isMusicOn.wrappedValue ? "Music On" : "Music Off")
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(Color(.label))
        }
        .tint(colorScheme == .light ? Color("Blue_00b4d8") : Color("Blue_0077b6"))
        .onChange(of: isMusicOn.wrappedValue, initial: false) { oldValue, newValue in
            MusicPlayerComponent.shared.shouldPlay = newValue
            if newValue {
                MusicPlayerComponent.shared.startBackgroundMusic(musicTitle: "WeGoTogether", volume: 1)
            } else {
                MusicPlayerComponent.shared.stopBackgroundMusic()
            }
        }
    }
}

#Preview {
    SettingModalComponent()
        .preferredColorScheme(.light)
}

#Preview {
    SettingModalComponent()
        .preferredColorScheme(.dark)
}
