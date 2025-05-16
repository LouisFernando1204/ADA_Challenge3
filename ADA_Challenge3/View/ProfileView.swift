//
//  ProfileView.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 08/05/25.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var isShowingInfoModal = false
    @State private var isShowingGetToKnowHerModal = false
    @State private var isShowingSettingsModal = false
    @State private var showBella = false
    @State private var showOddbodsRed = false
    @State private var showOddbodsBlue = false
    @Environment(\.colorScheme) var colorScheme
    private var screenWidth = ScreenSizeComponent().screenWidth
    private var screenHeight = ScreenSizeComponent().screenHeight
    
    var profile = ModelData.shared.profile
    var personalities = ModelData.shared.personalities
    var strengths = ModelData.shared.strengths
    
    @State private var personalityReason: String = ""
    
    struct RoundedCorner: Shape {
        var radius: CGFloat = 12
        var corners: UIRectCorner = .allCorners
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            return Path(path.cgPath)
        }
    }
    
    var body: some View {
        self.setUpProfileView(profile: self.profile, personalities: self.personalities, personalityReason: self.personalityReason, strengths: self.strengths, showBella: self.showBella, showOddbodsRed: self.showOddbodsRed, showOddbodsBlue: self.showOddbodsBlue, isShowingInfoModal: self.$isShowingInfoModal, isShowingGetToKnowHerModal: self.$isShowingGetToKnowHerModal, screenWidth: self.screenWidth, screenHeight: self.screenHeight)
    }
    
    private func getToKnowHerCard(isShowingGetToKnowHerModal: Binding<Bool>, personalityReason: Binding<String>, personalities: [Personality], personality: Int, screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        Button(action: {
            isShowingGetToKnowHerModal.wrappedValue = true
            personalityReason.wrappedValue = personalities[personality].reason
        }) {
            VStack(alignment: .leading, spacing: 0) {
                Image(personalities[personality].image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: screenHeight/4.5)
                    .clipShape(RoundedCorner(radius: 12, corners: [.topLeft, .topRight]))
                VStack(alignment: .leading, spacing: 0) {
                    Text(personalities[personality].name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.label))
                        .multilineTextAlignment(.leading)
                    Spacer()
                        .frame(height: 12)
                    Text(personalities[personality].type)
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundColor(Color(.secondaryLabel))
                        .multilineTextAlignment(.leading)
                }
                .padding(12)
            }
            .frame(width: screenWidth/2.5, height: screenHeight/3.4)
            .padding(.bottom, 12)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    private func herStrengthsCard(strengths: [Strength], strength: Int, screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        NavigationLink(destination: StrengthDetailView(
            recommendations: strengths[strength].recommendations
        )) {
            HStack {
                Image(strengths[strength].icon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: screenWidth/7, height: screenWidth/7)
                Spacer()
                    .frame(width: 12)
                Text(strengths[strength].name)
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(Color(.label))
                    .multilineTextAlignment(.leading)
                Spacer()
                Image(systemName: "chevron.right")
                    .renderingMode(.original)
                    .font(.headline)
                    .foregroundColor(Color(.secondaryLabel))
            }
            .padding(screenWidth/36)
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(12)
        }
    }
    
    private func setUpProfileView(profile: Profile, personalities: [Personality], personalityReason: String, strengths: [Strength], showBella: Bool, showOddbodsRed: Bool, showOddbodsBlue: Bool, isShowingInfoModal: Binding<Bool>, isShowingGetToKnowHerModal: Binding<Bool>, screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true, content: {
                ZStack(alignment: .center) {
                    VStack(alignment: .center, spacing: 0) {
                        self.profileImage(image: profile.image, showBella: showBella, isShowingSettingsModal: $isShowingSettingsModal, screenWidth: screenWidth, screenHeight: screenHeight)
                        VStack(alignment: .center, spacing: 0) {
                            self.getToKnowHerSection(personalities: personalities, personalityReason: $personalityReason, isShowingGetToKnowHerModal: $isShowingGetToKnowHerModal, isShowingInfoModal: $isShowingInfoModal, screenWidth: screenWidth, screenHeight: screenHeight)
                            Spacer()
                                .frame(height: 28)
                            self.herStrengthsSection(strengths: strengths, screenWidth: screenWidth, screenHeight: screenHeight)
                        }
                        .background(Color(.systemGroupedBackground))
                    }
                    VStack(alignment: .center, spacing: 0) {
                        self.oddBodsSection(showOddbodsRed: showOddbodsRed, showOddbodsBlue: showOddbodsBlue, screenWidth: screenWidth, screenHeight: screenHeight)
                        self.profileDataSection(profile: profile, screenWidth: screenWidth, screenHeight: screenHeight)
                    }
                    .onAppear {
                        self.showBella = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.showOddbodsRed = true
                            self.showOddbodsBlue = true
                        }
                    }
                }
                .sheet(isPresented: $isShowingInfoModal) {
                    InfoModalComponent(
                        bio: profile.bio,
                        contacts: profile.contacts
                    )
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
                }
                .sheet(isPresented: $isShowingGetToKnowHerModal) {
                    GetToKnowHerModalComponent(personalityReason: personalityReason)
                        .presentationDetents([.medium])
                }
                .sheet(isPresented: $isShowingSettingsModal) {
                    SettingModalComponent()
                        .presentationDetents([.medium])
                }
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(GlobalBackgroundComponent())
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func profileImage(image: String, showBella: Bool, isShowingSettingsModal: Binding<Bool>, screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        ZStack(alignment: .topTrailing) {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth/1.65, height: screenHeight/2.7)
                .clipped()
                .offset(y: showBella ? 0 : 100)
                .opacity(showBella ? 1 : 0)
                .animation(.easeInOut(duration: 0.6), value: showBella)
            Button(action: {
                isShowingSettingsModal.wrappedValue = true
            }) {
                Image(systemName: "gearshape")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth/15, height: screenHeight/30)
                    .foregroundColor(.primary)
            }
            
        }
    }
    
    private func getToKnowHerSection(personalities: [Personality], personalityReason: Binding<String>, isShowingGetToKnowHerModal: Binding<Bool>, isShowingInfoModal: Binding<Bool>, screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Text("Get to Know Her")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button(action: {
                    isShowingInfoModal.wrappedValue = true
                }) {
                    Image(systemName: "info.circle.fill")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth/16, height: screenWidth/16)
                        .foregroundColor(.primary)
                }
            }
            Spacer()
                .frame(height: 16)
            ScrollView(.horizontal, showsIndicators: false, content: {
                LazyHStack(alignment: .center, spacing: 12) {
                    ForEach(personalities.indices, id: \.self) { personality in
                        self.getToKnowHerCard(isShowingGetToKnowHerModal: $isShowingGetToKnowHerModal, personalityReason: $personalityReason, personalities: personalities, personality: personality, screenWidth: screenWidth, screenHeight: screenHeight)
                    }
                }
            })
        }
        .padding(.horizontal, 16)
        .padding(.top, screenHeight/6)
    }
    
    private func herStrengthsSection(strengths: [Strength], screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Her Strengths")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
            Spacer()
                .frame(height: 16)
            LazyVStack(alignment: .center, spacing: 12) {
                ForEach(strengths.indices, id: \.self) { strength in
                    self.herStrengthsCard(strengths: strengths, strength: strength, screenWidth: screenWidth, screenHeight: screenHeight)
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    
    private func oddBodsSection(showOddbodsRed: Bool, showOddbodsBlue: Bool, screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            Image("OddbodsRed")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth/3.4, height: screenWidth/3.4)
                .offset(y: showOddbodsRed ? 4 : 100)
                .opacity(showOddbodsRed ? 1 : 0)
                .animation(.bouncy(duration: 0.6, extraBounce: 0.2), value: showOddbodsBlue)
            Spacer()
            Image("OddbodsBlue")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth/3.4, height: screenWidth/3.4)
                .offset(y: showOddbodsBlue ? 4 : 100)
                .opacity(showOddbodsBlue ? 1 : 0)
                .animation(.bouncy(duration: 0.6, extraBounce: 0.2), value: showOddbodsBlue)
        }
        .padding(.horizontal, screenWidth/10)
    }
    
    private func profileDataSection(profile: Profile, screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        VStack(alignment: .center, spacing: 0) {
            Text(profile.name)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color(.label))
                .multilineTextAlignment(.center)
                .padding(.bottom, 6)
            Text(profile.role)
                .font(.headline)
                .fontWeight(.regular)
                .italic()
                .foregroundColor(Color(.secondaryLabel))
                .multilineTextAlignment(.center)
                .padding(.bottom, 14)
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .center, spacing: 0) {
                    Text("\(profile.age)")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.label))
                        .multilineTextAlignment(.center)
                    Spacer().frame(height: 8)
                    Text("Age")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(Color(.secondaryLabel))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                Rectangle()
                    .fill(Color(.secondaryLabel))
                    .frame(width: 1, height:60)
                VStack(alignment: .center, spacing: 0) {
                    Text(profile.hometown)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.label))
                        .multilineTextAlignment(.center)
                    Spacer().frame(height: 8)
                    Text("Hometown")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(Color(.secondaryLabel))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: screenHeight/6.5, alignment: .center)
        .padding(.horizontal, screenWidth/36)
        .padding(.vertical, screenWidth/36)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .padding(.horizontal, 16)
        .padding(.bottom, screenHeight/1.7)
    }
}

#Preview {
    ProfileView()
        .preferredColorScheme(.light)
}

#Preview {
    ProfileView()
        .preferredColorScheme(.dark)
}
