//
//  YoutubePlayerComponent.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 10/05/25.
//

import SwiftUI
import WebKit

struct YouTubePlayerComponent: UIViewRepresentable {
    let videoID: String
    @Binding var isLoading: Bool
    
    class WebViewWrapper: WKWebView {
        var didLoad = false
    }
    
    func makeUIView(context: Context) -> WebViewWrapper {
        let webView = WebViewWrapper()
        webView.navigationDelegate = context.coordinator
        webView.scrollView.isScrollEnabled = false
        return webView
    }
    
    func updateUIView(_ uiView: WebViewWrapper, context: Context) {
        guard !uiView.didLoad else { return }
        uiView.didLoad = true
        
        let embedURL = "https://www.youtube.com/embed/\(videoID)?playsinline=1"
        if let url = URL(string: embedURL) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: YouTubePlayerComponent
        
        init(_ parent: YouTubePlayerComponent) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
            MusicPlayerComponent.shared.shouldPlay = false
            MusicPlayerComponent.shared.stopBackgroundMusic()
            print("TEST MASUK SINI 0")
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
            //            MusicPlayerComponent.shared.shouldPlay = true
            //            MusicPlayerComponent.shared.startBackgroundMusic(musicTitle: "WeGoTogether", volume: 1)
        }
        
        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
            //            MusicPlayerComponent.shared.shouldPlay = true
            //            MusicPlayerComponent.shared.startBackgroundMusic(musicTitle: "WeGoTogether", volume: 1)
            print("TEST MASUK SINI 1")
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
            //            MusicPlayerComponent.shared.shouldPlay = true
            //            MusicPlayerComponent.shared.startBackgroundMusic(musicTitle: "WeGoTogether", volume: 1)
            print("TEST MASUK SINI 2")
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
            //            MusicPlayerComponent.shared.shouldPlay = true
            //            MusicPlayerComponent.shared.startBackgroundMusic(musicTitle: "WeGoTogether", volume: 1)
            print("TEST MASUK SINI 3")
        }
    }
}
