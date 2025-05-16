//
//  JourneyView.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 08/05/25.
//

import SwiftUI

struct JourneyView: View {
    
    @Environment(\.colorScheme) var colorScheme
    private var screenWidth = ScreenSizeComponent().screenWidth
    private var screenHeight = ScreenSizeComponent().screenHeight
    
    var projects = ModelData.shared.projects
    var tools = ModelData.shared.tools
    var routines = ModelData.shared.routines
    
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
        self.setUpJourneyView(projects: self.projects, tools: self.tools, routines: self.routines, screenWidth: self.screenWidth, screenHeight: self.screenHeight)
    }
    
    private func herWorksCard(projects: [Project], project: Int, screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        NavigationLink(destination: WorkDetailView(
            project: projects[project]
        )) {
            VStack(alignment: .leading, spacing: 0) {
                Image(projects[project].thumbnail)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: screenHeight/4.5)
                    .clipShape(RoundedCorner(radius: 12, corners: [.topLeft, .topRight]))
                VStack(alignment: .leading, spacing: 0) {
                    Text(projects[project].title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.label))
                        .multilineTextAlignment(.leading)
                    Spacer()
                        .frame(height: 12)
                    HStack(alignment: .center, spacing: 0) {
                        Text(projects[project].year)
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .foregroundColor(Color(.secondaryLabel))
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Image(systemName: "chevron.right.circle.fill")
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth/16, height: screenWidth/16)
                            .foregroundColor(colorScheme == .light ? Color("Blue_00b4d8") : Color("Blue_0077b6"))
                    }
                }
                .padding(12)
            }
            .frame(width: screenWidth/2.5, height: screenHeight/3.4)
            .padding(.bottom, 12)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    private func setUpJourneyView(projects: [Project], tools: [Tool], routines: [Routine], screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true, content: {
                Spacer()
                    .frame(height: 24)
                LazyVStack(alignment: .center, spacing: 0) {
                    self.herWorksSection(projects: projects, screenWidth: screenWidth, screenHeight: screenHeight)
                    Spacer()
                        .frame(height: 28)
                    self.herToolsSection(tools: tools, screenWidth: screenWidth, screenHeight: screenHeight)
                    Spacer()
                        .frame(height: 28)
                    self.herRoutinesSection(routines: routines, screenWidth: screenWidth, screenHeight: screenHeight)
                }
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(GlobalBackgroundComponent())
            .navigationTitle("Journey")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func herWorksSection(projects: [Project], screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Her Works")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
            Spacer()
                .frame(height: 16)
            ScrollView(.horizontal, showsIndicators: false, content: {
                LazyHStack(alignment: .center, spacing: 12) {
                    ForEach(projects.indices, id: \.self) { project in
                        self.herWorksCard(projects: projects, project: project, screenWidth: screenWidth, screenHeight: screenHeight)
                    }
                }
            })
            .padding(.horizontal, 16)
        }
    }
    
    private func herToolsSection(tools: [Tool], screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Her Tools")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
                .frame(height: 16)
            LazyHStack(alignment: .center, spacing: screenWidth/12) {
                ForEach(tools.indices, id: \.self) { tool in
                    VStack(alignment: .center, spacing: 12) {
                        Image(tools[tool].image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: screenWidth/12, height: screenHeight/12)
                        Text(tools[tool].name)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.label))
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(screenWidth/24)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.horizontal, 16)
    }
    
    private func herRoutinesSection(routines: [Routine], screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        VStack(alignment: .center, spacing: 0){
            Text("Her Routines")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
                .frame(height: 16)
            LazyVStack(alignment: .center, spacing: 0) {
                ForEach(routines.indices, id: \.self) { routine in
                    HStack(alignment: .center, spacing: 0) {
                        VStack(alignment: .leading, spacing: screenWidth/40) {
                            Text(routines[routine].title)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.label))
                                .multilineTextAlignment(.leading)
                            Text(routines[routine].time)
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundColor(Color(.secondaryLabel))
                                .multilineTextAlignment(.trailing)
                        }
                        .padding(.vertical, screenWidth/60)
                        Spacer()
                    }
                    if (routines.count - 1) != routine {
                        Divider()
                            .frame(height: 20)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(screenWidth/24)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    JourneyView()
        .preferredColorScheme(.light)
}

#Preview {
    JourneyView()
        .preferredColorScheme(.dark)
}
