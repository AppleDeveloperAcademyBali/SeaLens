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
                let minCardWidth: CGFloat = 200
                // Slightly tighter spacing
                let spacing: CGFloat = 12
                
                // calculate how many cards can fit per row
                let cardsPerRow = max(3, Int((availableWidth + spacing) / (minCardWidth + spacing)))
                let cardWidth = (availableWidth - spacing * CGFloat(cardsPerRow - 1)) / CGFloat(cardsPerRow)
                
                ScrollView {
                    if fishFamilies.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "fish")
                                .font(.system(size: 48))
                                .foregroundStyle(.secondary)
                            Text("No fish detected")
                                .font(.title3)
                                .foregroundStyle(.secondary)
                            Text("Fish data will appear here once processing is complete")
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                    } else {
                        FishFamilyGridContent(
                            families: fishFamilies,
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



private struct FishFamilyGridContent: View {
    let families: [FishFamily]
    let cardWidth: CGFloat
    let spacing: CGFloat
    
    var body: some View {
        
        FlowHStack(horizontalSpacing: spacing, verticalSpacing: spacing) {
            // Use explicit id to avoid identity issues across contexts.
            ForEach(families, id: \.uid) { family in
                FishFamilyCard(
                    familyName: family.fishFamilyReference?.commonName ?? "Unknown",
                    latinName: family.fishFamilyReference?.latinName ?? "",
                    fishCount: Int(family.numOfFishDetected),
                    imageURL: "samplePicture"
                )
                // Increase height to show more content per card
                .frame(width: cardWidth, height: 280)
            }
        }
        
    }
}





#Preview {
    FishFamilyGrid(fishFamilies: Footage.sampleData.first?.fishFamily ?? [])
        .frame(width: 1200, height: 800)
        .padding()
        .previewLayout(.sizeThatFits)
}

