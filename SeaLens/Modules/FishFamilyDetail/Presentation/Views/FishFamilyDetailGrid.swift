//
//  FishFamilyDetailGrid.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 14/11/2025.
//

import SwiftUI

struct FishFamilyDetailGrid: View {
    var fish: [Fish]
    
    private let cardWidth: CGFloat = 200
    private let spacing: CGFloat = 12

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.gray.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.black.opacity(0.08), lineWidth: 0.5)
                )

            ScrollView {
                if fish.isEmpty {
                    Text("No fish photos")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    let columns = [
                        GridItem(.adaptive(minimum: cardWidth), spacing: spacing)
                    ]
                    
                    LazyVGrid(columns: columns, spacing: spacing) {
                        ForEach(fish, id: \.uid) { fish in
                            FishCard(imageURL: fish.imageUrl)
                                .frame(width: cardWidth, height: cardWidth / 1.2)
                        }
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 24)
                }
            }
            .scrollIndicators(.hidden)
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
