//
//  GlobalBackground.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 08/05/25.
//

import SwiftUI

struct GlobalBackgroundComponent: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color("GradientBackground_1"),
                    Color("GradientBackground_2"),
                    Color(.systemGroupedBackground),
                    Color(.systemGroupedBackground)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            content
        }
    }
}
