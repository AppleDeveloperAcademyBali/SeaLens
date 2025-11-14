//
//  FishCard.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 14/11/2025.
//

import SwiftUI

struct FishCard: View {
    
    var imageURL: String
    
    var body: some View {
        
        GeometryReader { geometry in
            Image(imageURL)
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(radius: 3)
        }
        .aspectRatio(1.3, contentMode: .fit)
        
    }
}

#Preview {
    FishCard(imageURL: "samplePicture")
        .frame(width: 240, height: 200)
        .padding()
}
