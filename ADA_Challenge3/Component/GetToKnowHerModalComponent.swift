//
//  GetToKnowHerModalComponent.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 12/05/25.
//

import SwiftUI

struct GetToKnowHerModalComponent: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    private var screenWidth = ScreenSizeComponent().screenWidth
    private var screenHeight = ScreenSizeComponent().screenHeight
    var personalityReason: String
    
    init(personalityReason: String = "") {
        self.personalityReason = personalityReason
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true, content: {
                VStack(alignment: .center, spacing: 16) {
                    Text(self.personalityReason)
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(Color(.label))
                        .baselineOffset(4)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 8)
                }
                .padding(16)
                .navigationTitle("The Reason Behind It")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            dismiss()
                        }
                        .foregroundColor(colorScheme == .light ? Color("Blue_00b4d8") : Color("Blue_0077b6"))
                    }
                }
            })
        }
    }
}

#Preview {
    GetToKnowHerModalComponent()
        .preferredColorScheme(.light)
}

#Preview {
    GetToKnowHerModalComponent()
        .preferredColorScheme(.dark)
}
