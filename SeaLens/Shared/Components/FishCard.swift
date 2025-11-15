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
        Image(imageURL)
            .resizable()
            .scaledToFill()
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .shadow(radius: 3)
            .clipped()
    }
}


#Preview {
    FishCard(imageURL: "samplePicture")
        .frame(width: 240, height: 200)
        .padding()
}
