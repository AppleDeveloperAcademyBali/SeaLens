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
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.06))
                .stroke(Color.black.opacity(0.08), lineWidth: 0.5)
            
            ScrollView {
                FishFamilyGridContent(families: fishFamilies)
                    .padding(20)
                    .padding(.bottom, 80)
            }
            .clipped()
            
        }
        .padding(.bottom)
        
    }
}

private struct FishFamilyGridContent: View {
    let families: [FishFamily]
    
    private let spacing: CGFloat = 25

    let columns = [
        GridItem(.adaptive(minimum: 240, maximum: 300))
    ]
    
    var body: some View {
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
                }
                .buttonStyle(.plain)
            }
        }
    }
}
