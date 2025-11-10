//
//  FishFamilyGrid.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 9/11/2025.
//



import SwiftUI



struct FishFamilyGrid: View {

    
    var body: some View {
        
        ZStack  {
            
            // gray rectangle
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.gray.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.black.opacity(0.1), lineWidth: 0.5)
                )
            
                
                GeometryReader { geometry in
                    let availableWidth = geometry.size.width - 48
                    let minCardWidth: CGFloat = 240
                    let spacing: CGFloat = 16
                    
                    // calcualte how many cards can fit per row
                    let cardsPerRow = max(3, Int((availableWidth + spacing) / (minCardWidth + spacing)))
                    
                    
                    let cardWidth = (availableWidth - spacing * CGFloat(cardsPerRow - 1)) / CGFloat(cardsPerRow)
                    
                    ScrollView  {

                
                    FlowHStack(horizontalSpacing: spacing, verticalSpacing: spacing) {
                        ForEach(Footage.sampleData) { footage in
                            ForEach(footage.fishFamily) { family in
                                FishFamilyCard(
                                    familyName: family.fishFamilyReference?.commonName ?? "Unknown",
                                    latinName: family.fishFamilyReference?.latinName ?? "",
                                    fishCount: Int(family.numOfFishDetected),
                                    imageURL: "samplePicture"
                                )
                                .frame(width: cardWidth, height: 240)
                            }
                        }
                        
                    }
                    .frame(maxWidth: .infinity) 
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                }
                .scrollIndicators(.hidden)
            }
        }
        
    }
}


#Preview {
    FishFamilyGrid()
}
