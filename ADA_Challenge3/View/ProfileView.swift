//
//  ProfileView.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 08/05/25.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var isShowingInfoModal = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true, content: {
                ZStack(alignment: .center) {
                    VStack(alignment: .center, spacing: 0) {
                        ZStack(alignment: .topTrailing) {
                            Image("BellaProfilePicture")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 240, height: 320)
                                .clipped()
                            Button(action: {
                                isShowingInfoModal = true
                            }) {
                                Image(systemName: "info.circle.fill")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(Color("Blue_00b4d8"))
                                    .padding(.trailing, -24)
                            }
                        }
                        VStack(alignment: .center, spacing: 0) {
                            Text("Get to Know Her")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 16)
                                .padding(.top, 120)
                            Spacer()
                                .frame(height: 16)
                                .background(Color.red)
                            ScrollView(.horizontal, showsIndicators: false, content: {
                                LazyHStack(alignment: .center, spacing: 12) {
                                    ForEach(0..<6) { index in
                                        VStack(alignment: .center, spacing: 8) {
                                            Image("DummyImage")
                                                .resizable()
                                                .frame(width: 120, height: 120)
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                                .padding(.bottom, 4)
                                            Text("Text")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.primary)
                                                .multilineTextAlignment(.center)
                                            Text("Text")
                                                .font(.subheadline)
                                                .fontWeight(.regular)
                                                .foregroundColor(.secondary)
                                                .multilineTextAlignment(.center)
                                        }
                                        .frame(width: 140, height: 180)
                                        .padding(4)
                                        .padding(.vertical, 8)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.white)
                                        )
                                    }
                                }
                            })
                            .padding(.horizontal, 16)
                            Spacer()
                                .frame(height: 28)
                            Text("Her Strengths")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 16)
                            Spacer()
                                .frame(height: 16)
                            LazyVStack(alignment: .center, spacing: 12) {
                                ForEach(0..<3) { index in
                                    NavigationLink(destination: JourneyView()) {
                                        HStack {
                                            Image("DummyImage")
                                                .resizable()
                                                .frame(width: 45, height: 45)
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                                .padding(.trailing, 6)
                                            Text("Text")
                                                .font(.headline)
                                                .fontWeight(.regular)
                                                .foregroundColor(.primary)
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .renderingMode(.original)
                                                .font(.headline)
                                                .foregroundColor(.gray)
                                        }
                                        .padding(14)
                                        .background(Color(.white))
                                        .cornerRadius(12)
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        .background(Color(.systemGray6))
                    }
                    VStack(alignment: .center, spacing: 0) {
                        Text("Gabriella Natasya Pingky Davis")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 6)
                        Text("A 3D Modeler")
                            .font(.headline)
                            .fontWeight(.regular)
                            .italic()
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 14)
                        HStack(alignment: .center, spacing: 0) {
                            VStack(alignment: .center, spacing: 0) {
                                Text("25")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.center)
                                Spacer().frame(height: 8)
                                Text("Age")
                                    .font(.headline)
                                    .fontWeight(.regular)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 1.5, height:60)
                            VStack(alignment: .center, spacing: 0) {
                                Text("Surabaya")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.center)
                                Spacer().frame(height: 8)
                                Text("Hometown")
                                    .font(.headline)
                                    .fontWeight(.regular)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 130, alignment: .center)
                    .padding(10)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(.horizontal, 16)
                    .padding(.bottom, 320)
                }
                .sheet(isPresented: $isShowingInfoModal) {
                    InfoModalComponent()
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                }
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(GlobalBackground())
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ProfileView()
}
