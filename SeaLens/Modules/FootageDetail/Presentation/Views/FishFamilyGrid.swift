//
//  FishFamilyGrid.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 9/11/2025.
//
import SwiftUI

struct FishFamilyGrid: View {
    
    var fishFamilies: [FishFamily]

    
    var body: some View {
        
        ZStack  {
            
            // gray rectangle
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.gray.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.black.opacity(0.08), lineWidth: 0.5)
                )
                
            GeometryReader { geometry in
                // Reduce margins slightly to gain space
                let outerPadding: CGFloat = 32
                let availableWidth = geometry.size.width - (outerPadding * 2)
                
                // Allow smaller cards so more fit per row
                let minCardWidth: CGFloat = 258
                // Slightly tighter spacing
                let spacing: CGFloat = 25
                
                // calculate how many cards can fit per row
                let cardsPerRow = max(3, Int((availableWidth + spacing) / (minCardWidth + spacing)))
                let cardWidth = (availableWidth - spacing * CGFloat(cardsPerRow - 1)) / CGFloat(cardsPerRow)
                
//                ScrollView {
//
//                    FishFamilyGridContent(
//                        families: fishFamilies,
//
//                    )
//                    .padding(.horizontal, outerPadding)
//                    .padding(.vertical, 32)
//                
//                    FlowHStack(horizontalSpacing: spacing, verticalSpacing: spacing) {
//                        ForEach(Footage.sampleData) { footage in
//                            ForEach(footage.fishFamily ?? []) { family in
//                                FishFamilyCard(
//                                    familyName: family.fishFamilyReference?.commonName ?? "Unknown",
//                                    latinName: family.fishFamilyReference?.latinName ?? "",
//                                    fishCount: Int(family.numOfFishDetected),
//                                    imageURL: "samplePicture"
//                                )
//                                .frame(width: cardWidth, height: 240)
//                            }
//                        }
//                        
//                    }
//                    .frame(maxWidth: .infinity) 
//                    .padding(.horizontal, 24)
//                    .padding(.vertical, 24)
//                }
//                .scrollIndicators(.hidden)
            }

        }
        
    }
}

private struct FishFamilyGridContent: View {
    let families: [FishFamily]
    
    private let cardWidth: CGFloat = 258
    private let spacing: CGFloat = 25
    private let cardAspectRatio: CGFloat = 274.0 / 258.0

    var body: some View {
        let columns = [
            GridItem(.adaptive(minimum: cardWidth), spacing: spacing)
        ]

        LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(families, id: \.uid) { family in
                NavigationLink(value: family.uid) {
                    FishFamilyCard(
                        familyName: family.fishFamilyReference?.commonName ?? "",
                        latinName: family.fishFamilyReference?.latinName ?? "",
                        photoCount: family.fishes.count,
                        fishCount: Int(family.numOfFishDetected),
                        imageURL: "samplePicture"
                    )
                    .frame(width: cardWidth, height: cardWidth + cardAspectRatio)
                }
                .buttonStyle(.plain)
            }
        }
    }
}
