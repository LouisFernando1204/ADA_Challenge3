//
//  InfoModalComponent.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 08/05/25.
//

import SwiftUI

struct InfoModalComponent: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true, content: {
                VStack(alignment: .center, spacing: 16) {
                    Text("Gabriella Natasya, often called Bella, is a passionate 3D Modeler from Surabaya who studied Animation at Limkokwing University of Creative Technology, Malaysia. She has worked on various animated projects such as Oddbods, Antiks, and Minibods during her time at One Animation, showcasing her skills in 3D asset creation and basic rigging using tools like Blender, Maya, and ZBrush.")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(.primary)
                        .baselineOffset(4)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 8)
                    ForEach(0..<3) { index in
                        VStack(alignment: .center, spacing: 0) {
                            HStack(alignment: .center, spacing: 0) {
                                Image("LinkedInLogo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 44, height: 44)
                                Spacer()
                                Link(destination: URL(string: "linkedin.com/in/gabriellanatasya")!) {
                                    Text("Gabriella Natasya Pingky Davis")
                                        .font(.headline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.blue)
                                        .baselineOffset(4)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                }
                            }
                        }
                        .padding(14)
                        .frame(width: .infinity, height: .infinity, alignment: .center)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemGray6)
                                     )
                        )
                    }
                }
                .padding(16)
                .navigationTitle("Get Connected")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            dismiss()
                        }
                    }
                }
            })
            Spacer()
        }
    }
}

#Preview {
    InfoModalComponent()
}
