//
//  FishCard.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 8/11/2025.
//

import SwiftUI

struct FishFamilyCard: View {
    
    var familyName: String
    var latinName: String
    var photoCount: Int
    var fishCount: Int
    var imageURL: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            // Fish image
            Image(imageURL)
                .resizable()
                .scaledToFill()
                .frame(height: 180)
                .clipped()
            
            // White background section with text
            VStack(spacing: 13)    {
                VStack(alignment: .leading, spacing: 2) {
                    Text(familyName)
                        .textstyles(.title2Regular)
                        .bold(true)
                    
                    Text(latinName)
                        .textstyles(.bodyRegular)
                        .italic()
                }
                
                // Icons row
                HStack(spacing: 8) {  // Reduced spacing
                    HStack(spacing: 4) {
                        Image(systemName: "fish")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(fishCount)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    
                    HStack(spacing: 4) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(photoCount)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}


#Preview {
    FishFamilyCard(
        familyName: "Surgeonfish",
        latinName: "Acanthuridae",
        photoCount: 11,
        fishCount: 4,
        imageURL: "samplePicture"
    )
    .frame(width: 258, height: 274)
    .padding()
}
