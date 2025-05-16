//
//  WorkDetailModalComponent.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 09/05/25.
//

import SwiftUI

struct WorkDetailView: View {
    
    @State private var currentImageIndex = 0
    @State private var isLoading = true
    @Environment(\.colorScheme) var colorScheme
    private var screenWidth = ScreenSizeComponent().screenWidth
    private var screenHeight = ScreenSizeComponent().screenHeight
    let carouselImages = ["SantaSwap_1", "SantaSwap_2", "Antiks_2"]
    var project: Project
    
    init(project: Project = Project(
        title: "",
        projectLocation: "",
        year: "",
        description: "",
        role: "",
        thumbnail: "",
        projectVideoId: "",
        images: []
    )) {
        self.project = project
    }
    
    var body: some View {
        self.setUpWorkDetailView(currentImageIndex: self.currentImageIndex, isLoading: self.isLoading, project: self.project, screenWidth: self.screenWidth, screenHeight: self.screenHeight)
    }
    
    private func setUpWorkDetailView(currentImageIndex: Int, isLoading: Bool, project: Project, screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true, content: {
                Spacer()
                    .frame(height: 24)
                LazyVStack(alignment: .center, spacing: 20) {
                    self.projectVideoSection(projectVideoId: project.projectVideoId, isLoading: isLoading)
                    self.headerProjectSection(projectTitle: project.title, projectLocation: project.projectLocation, projectYear: project.year)
                    self.bodyProjectSection(projectDescription: project.description, projectRole: project.role)
                    self.featuredWorkSection(projectImages: project.images, currentImageIndex: $currentImageIndex, screenHeight: screenHeight)
                }
                .padding(.horizontal, 16)
            })
            .onDisappear {
                MusicPlayerComponent.shared.startBackgroundMusic(musicTitle: "WeGoTogether", volume: 1)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(GlobalBackgroundComponent())
            .navigationTitle("Work Details")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func projectVideoSection(projectVideoId: String, isLoading: Bool) -> some View {
        ZStack {
            YouTubePlayerComponent(videoID: projectVideoId, isLoading: $isLoading)
                .frame(height: screenHeight/4.5)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 4)
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    .scaleEffect(1.5)
            }
        }
    }
    
    private func headerProjectSection(projectTitle: String, projectLocation: String, projectYear: String) -> some View {
        VStack(alignment: .center, spacing: 0) {
            Text(projectTitle)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color(.label))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
                .frame(height: 8)
            HStack(alignment: .center, spacing: 0) {
                Text("At \(projectLocation)")
                    .font(.title3)
                    .fontWeight(.regular)
                    .foregroundColor(Color(.secondaryLabel))
                Spacer()
                Text("\(projectYear)")
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(Color(.secondaryLabel))
            }
        }
    }
    
    private func bodyProjectSection(projectDescription: String, projectRole: String) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(projectDescription)
                .font(.headline)
                .fontWeight(.regular)
                .foregroundColor(Color(.label))
                .baselineOffset(4)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 8)
            Text(projectRole)
                .font(.headline)
                .fontWeight(.regular)
                .foregroundColor(Color(.label))
                .baselineOffset(4)
                .multilineTextAlignment(.leading)
        }
    }
    
    private func featuredWorkSection(projectImages: [String], currentImageIndex: Binding<Int>, screenHeight: CGFloat) -> some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Featured Works")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
                .frame(height: 16)
            TabView(selection: $currentImageIndex) {
                ForEach(projectImages.indices, id: \.self) { projectImage in
                    Image(projectImages[projectImage])
                        .resizable()
                        .scaledToFill()
                        .tag(projectImage)
                        .frame(maxWidth: .infinity)
                        .clipped()
                }
            }
            .frame(height: screenHeight/4.5)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
                    withAnimation {
                        currentImageIndex.wrappedValue = (currentImageIndex.wrappedValue + 1) % carouselImages.count
                    }
                }
            }
        }
    }
}

#Preview {
    WorkDetailView()
        .preferredColorScheme(.light)
}

#Preview {
    WorkDetailView()
        .preferredColorScheme(.dark)
}
