//
//  QuizView.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 14/05/25.
//

import SwiftUI

struct QuizView: View {
    
    @State var show3DBella: Bool = false
    @State private var isShowingQuizModal = false
    @Environment(\.colorScheme) var colorScheme
    private var screenWidth = ScreenSizeComponent().screenWidth
    private var screenHeight = ScreenSizeComponent().screenHeight
    @State private var scrollTarget = 0
    let autoScrollInterval: TimeInterval = 3.0
    let loopedWorkStyles = Array(repeating: ModelData.shared.workStyles, count: 3).flatMap { $0 }
    
    var workStyles = ModelData.shared.workStyles
    
    var body: some View {
        self.setUpQuizView(show3DBella: self.show3DBella, isShowingQuizModal: self.isShowingQuizModal, screenWidth: self.screenWidth, screenHeight: self.screenHeight, scrollTarget: self.scrollTarget, autoScrollInterval: self.autoScrollInterval, loopedWorkStyles: self.loopedWorkStyles, workStyles: self.workStyles)
    }
    
    private func setUpQuizView(show3DBella: Bool, isShowingQuizModal: Bool, screenWidth: CGFloat, screenHeight: CGFloat, scrollTarget: Int, autoScrollInterval: Double, loopedWorkStyles: [WorkStyle], workStyles: [WorkStyle]) -> some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true, content: {
                VStack(alignment: .center, spacing: screenHeight/34) {
                    self.bellaAndInformationSection(show3DBella: $show3DBella, screenWidth: screenWidth, screenHeight: screenHeight)
                    self.startTheQuizButton(isShowingQuizModal: $isShowingQuizModal)
                    self.howSheWorksSection(workStyles: workStyles, scrollTarget: $scrollTarget, loopedWorkStyles: loopedWorkStyles, screenWidth: screenWidth, screenHeight: screenHeight, autoScrollInterval: autoScrollInterval)
                }
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(GlobalBackgroundComponent())
            .navigationTitle("Quiz")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func bellaAndInformationSection(show3DBella: Binding<Bool>, screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        ZStack(alignment: .bottomTrailing) {
            HStack(alignment: .center, spacing: 0) {
                ZStack(alignment: .center) {
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color(colorScheme == .light ? "Blue_00b4d8" : "Blue_90e0ef"),
                            Color(colorScheme == .light ? "Blue_00b4d8" : "Blue_90e0ef"),
                            Color(colorScheme == .light ? "Blue_0077b6" : "Blue_caf0f8")
                        ]),
                        center: .center,
                        startRadius: 10,
                        endRadius: 150
                    )
                    .clipShape(Circle())
                    .shadow(color: Color("Blue_00b4d8").opacity(0), radius: 0, x: 0, y: 0)
                    .blur(radius: 60)
                    .padding(.top, screenHeight/20)
                    Image("3DBella")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .clipped()
                        .offset(y: show3DBella.wrappedValue ? 0 : 100)
                        .opacity(show3DBella.wrappedValue ? 1 : 0)
                        .animation(.easeInOut(duration: 0.6), value: show3DBella.wrappedValue)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, screenWidth/4)
            VStack(alignment: .center, spacing: 0) {
                Text("Are You a Good Match with Bella? 🤔")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.label))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 12)
                Text("Answer a few questions about how you work and see if you’d make a great team with her!")
                    .font(.headline)
                    .fontWeight(.regular)
                    .italic()
                    .foregroundColor(Color(.secondaryLabel))
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(screenWidth/24)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .padding(.horizontal, 16)
        }
        .onAppear {
            show3DBella.wrappedValue = true
        }
        .sheet(isPresented: $isShowingQuizModal) {
            QuizModalComponent(
                
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
    
    private func startTheQuizButton(isShowingQuizModal: Binding<Bool>) -> some View {
        Button(action: {
            isShowingQuizModal.wrappedValue = true
        }) {
            Text("Start the Quiz ✨")
                .font(.headline)
                .foregroundColor(Color(.white))
                .frame(maxWidth: .infinity)
                .padding()
                .background(colorScheme == .light ? Color("Blue_00b4d8") : Color("Blue_0077b6"))
                .cornerRadius(12)
                .padding(.horizontal, 16)
        }
    }
    
    private func howSheWorksSection(workStyles: [WorkStyle], scrollTarget: Binding<Int>, loopedWorkStyles: [WorkStyle], screenWidth: CGFloat, screenHeight: CGFloat, autoScrollInterval: Double) -> some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            VStack(alignment: .center, spacing: 0) {
                Text("How She Works")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                Spacer()
                    .frame(height: 16)
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(alignment: .center, spacing: 12) {
                            ForEach(loopedWorkStyles.indices, id: \.self) { index in
                                let workStyle = loopedWorkStyles[index]
                                VStack(alignment: .leading, spacing: 12) {
                                    Text(workStyle.title)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(.label))
                                        .multilineTextAlignment(.leading)
                                    Text(workStyle.description)
                                        .font(.headline)
                                        .fontWeight(.regular)
                                        .foregroundColor(Color(.label))
                                        .multilineTextAlignment(.leading)
                                }
                                .padding(screenWidth/36)
                                .frame(width: screenWidth - 32, height: screenHeight/5.5)
                                .background(Color(.secondarySystemGroupedBackground))
                                .cornerRadius(12)
                                .id(index)
                                .scrollTransition(.animated) { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1 : 0.3)
                                        .scaleEffect(phase.isIdentity ? 1 : 0.75)
                                        .blur(radius: phase.isIdentity ? 0 : 10)
                                        .rotation3DEffect(
                                            .degrees(phase.isIdentity ? 0 : 30),
                                            axis: (x: 1, y: 1, z: 0)
                                        )
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: autoScrollInterval, repeats: true) { _ in
                            DispatchQueue.main.async {
                                withAnimation {
                                    scrollTarget.wrappedValue += 1
                                    proxy.scrollTo(scrollTarget.wrappedValue, anchor: .center)
                                }
                                if scrollTarget.wrappedValue == loopedWorkStyles.count - 1 {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                        withAnimation(.none) {
                                            scrollTarget.wrappedValue = ModelData.shared.workStyles.count
                                            proxy.scrollTo(scrollTarget.wrappedValue, anchor: .center)
                                        }
                                    }
                                }
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            scrollTarget.wrappedValue = ModelData.shared.workStyles.count
                            proxy.scrollTo(scrollTarget.wrappedValue, anchor: .center)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    QuizView()
        .preferredColorScheme(.light)
}

#Preview {
    QuizView()
        .preferredColorScheme(.dark)
}
