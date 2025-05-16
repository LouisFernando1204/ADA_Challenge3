//
//  StrengthDetailView.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 09/05/25.
//

import SwiftUI

struct StrengthDetailView: View {
    
    @State private var expandedIndices: Set<Int> = []
    @Environment(\.colorScheme) var colorScheme
    private var screenWidth = ScreenSizeComponent().screenWidth
    private var screenHeight = ScreenSizeComponent().screenHeight
    var recommendations: [Colleague]
    
    init(recommendations: [Colleague] = []) {
        self.recommendations = recommendations
    }
    
    var body: some View {
        self.setUpStrengthDetailView(recommendations: self.recommendations, expandedIndices: self.expandedIndices, screenWidth: self.screenWidth, screenHeight: self.screenHeight)
    }
    
    private func setUpStrengthDetailView(recommendations: [Colleague], expandedIndices: Set<Int>, screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true, content: {
                Spacer()
                    .frame(height: 24)
                LazyVStack(alignment: .center, spacing: 12) {
                    ForEach(recommendations.indices, id: \.self) { recommendation in
                        let isExpanded = expandedIndices.contains(recommendation)
                        self.recommendationCard(recommendations: recommendations, recommendation: recommendation, isExpanded: isExpanded, expandedIndices: $expandedIndices, screenWidth: screenWidth, screenHeight: screenHeight)
                    }
                }
                .padding(.horizontal, 16)
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(GlobalBackgroundComponent())
            .navigationTitle("What Other Says")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func recommendationCard(recommendations: [Colleague], recommendation: Int, isExpanded: Bool, expandedIndices: Binding<Set<Int>>, screenWidth: CGFloat, screenHeight: CGFloat) -> some View {
        VStack(alignment: .center, spacing: 8) {
            HStack(alignment: .center, spacing: 12) {
                Image(recommendations[recommendation].image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 4) {
                    Text(recommendations[recommendation].name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.label))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(recommendations[recommendation].role)
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(Color(.secondaryLabel))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            Spacer()
                .frame(height: 2)
            Text(recommendations[recommendation].recommendationLetter)
                .font(.headline)
                .fontWeight(.regular)
                .foregroundColor(Color(.label))
                .baselineOffset(4)
                .multilineTextAlignment(.leading)
                .lineLimit(isExpanded ? nil : 3)
                .truncationMode(.tail)
            Button(action: {
                if isExpanded {
                    expandedIndices.wrappedValue.remove(recommendation)
                } else {
                    expandedIndices.wrappedValue.insert(recommendation)
                }
            }) {
                Text(isExpanded ? "Show Less" : "Show More")
                    .font(.subheadline)
                    .foregroundColor(colorScheme == .light ? Color("Blue_00b4d8") : Color("Blue_0077b6"))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 4)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(screenWidth/25)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    StrengthDetailView()
        .preferredColorScheme(.light)
}

#Preview {
    StrengthDetailView()
        .preferredColorScheme(.dark)
}
