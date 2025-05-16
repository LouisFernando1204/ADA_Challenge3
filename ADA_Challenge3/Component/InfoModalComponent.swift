//
//  InfoModalComponent.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 08/05/25.
//

import SwiftUI

struct InfoModalComponent: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    private var screenWidth = ScreenSizeComponent().screenWidth
    private var screenHeight = ScreenSizeComponent().screenHeight
    var bio: String
    var contacts: [Contact]
    
    init(bio: String = "", contacts: [Contact] = []) {
        self.bio = bio
        self.contacts = contacts
    }
    
    var body: some View {
        self.setUpInfoModal(bio: self.bio, contacts: self.contacts, screenWidth: self.screenWidth, screenHeight: self.screenHeight)
    }
    
    private func setUpInfoModal(bio: String, contacts: [Contact], screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true, content: {
                VStack(alignment: .center, spacing: 16) {
                    self.bioProfileSection(bio: bio)
                    self.contactSection(contacts: contacts)
                    Spacer()
                    self.oddBodsImageSection()
                }
                .padding(16)
                .navigationTitle("Get Connected")
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
    
    private func bioProfileSection(bio: String) -> some View {
        Text(bio)
            .font(.headline)
            .fontWeight(.regular)
            .foregroundColor(Color(.label))
            .baselineOffset(4)
            .multilineTextAlignment(.leading)
            .padding(.bottom, 8)
    }
    
    private func contactSection(contacts: [Contact]) -> some View {
        ForEach(contacts.indices, id: \.self) { contact in
            VStack(alignment: .center, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    Image(contacts[contact].image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth/9, height: screenWidth/9)
                    Spacer()
                    Link(destination: URL(string: contacts[contact].urlContact)!) {
                        Text(contacts[contact].username)
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
            .padding(screenWidth/25)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemBackground)
                         )
            )
        }
    }
    
    private func oddBodsImageSection() -> some View {
        ZStack(alignment: .bottom) {
            Image("OddbodsFamily")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .clipped()
                .shadow(radius: 12, x: 0, y: 12)
            RoundedRectangle(cornerRadius: 20)
                .fill(colorScheme == .light ? Color("Blue_00b4d8") : Color("Blue_0077b6"))
                .frame(height: screenWidth/40)
        }
    }
}

#Preview {
    InfoModalComponent()
        .preferredColorScheme(.light)
}

#Preview {
    InfoModalComponent()
        .preferredColorScheme(.dark)
}
