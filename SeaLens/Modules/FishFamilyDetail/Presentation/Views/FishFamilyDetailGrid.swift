//
//  FishFamilyDetailGrid.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 14/11/2025.
//

import SwiftUI

struct FishFamilyDetailGrid: View {
    
    var fish: [Fish]
    
    var body: some View {
        
        ZStack {
            
            // gray rectangle background
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.gray.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.black.opacity(0.08), lineWidth: 0.5)
                )
            
            
            GeometryReader { geometry in
                 let outerPadding: CGFloat = 32
                 let availableWidth = geometry.size.width - (outerPadding * 2)
                 
                 let minCardWidth: CGFloat = 200
                 let spacing: CGFloat = 12
                 
                 let cardsPerRow = max(3, Int((availableWidth + spacing) / (minCardWidth + spacing)))
                 let cardWidth = (availableWidth - spacing * CGFloat(cardsPerRow - 1)) / CGFloat(cardsPerRow)
                 
                 ScrollView {
                     if fish.isEmpty    {
                         Text("No fish photos")
                             .font(.title3)
                             .foregroundStyle(.secondary)
                    
                         .frame(maxWidth: .infinity, maxHeight: .infinity)
                         .padding()
                     } else {
                         FishFamilyDetailGridContent(
                             fish: fish,
                             cardWidth: cardWidth,
                             spacing: spacing
                         )
                         .padding(.horizontal, outerPadding)
                         .padding(.vertical, 24)
                     }
                 }
                 .scrollIndicators(.hidden)
             }
         }
     }
 }

private struct FishFamilyDetailGridContent: View {
    let fish: [Fish]
    let cardWidth: CGFloat
    let spacing: CGFloat
    
    var body: some View {
        FlowHStack(horizontalSpacing: spacing, verticalSpacing: spacing) {
            ForEach(fish, id: \.uid) { fish in
                FishCard(imageURL: fish.imageUrl)
                    .frame(width: cardWidth, height: cardWidth / 1.2)
            }
        }
    }
}


#Preview {
    // Create multiple copies of one fish for testing
    let sampleFish = Footage.sampleData[0].fishFamily.first!.fish.first!
    let multipleFish = Array(repeating: sampleFish, count: 15)
    
    return FishFamilyDetailGrid(fish: multipleFish)
        .frame(width: 1200, height: 800)
        .padding()
}
