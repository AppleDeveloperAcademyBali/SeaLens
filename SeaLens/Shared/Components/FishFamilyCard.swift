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
                .frame(height: 150)
                .clipped()
            
            VStack (alignment: .leading) {
                Text(familyName)
                    .textstyles(.title2Regular)
                    .bold(true)
                
                Text(latinName)
                    .textstyles(.bodyRegular)
                    .italic()
                
                HStack(spacing: 8) {  // Reduced spacing
                    Group {
                        HStack(spacing: 4) {
                            Image(systemName: "fish")
                            Text("\(fishCount)")
                        }
                        HStack(spacing: 4) {
                            Image(systemName: "photo.on.rectangle.angled")
                            Text("\(photoCount)")
                        }
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
            }
            .padding(.horizontal)
            .padding(.top, 4)
            .padding(.bottom, 16)
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 31)
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
    .frame(width: 250, height: 250)
//    .background(.red)
    .padding()
}
