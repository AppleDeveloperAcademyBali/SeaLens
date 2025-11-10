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
    var fishCount: Int
    var imageURL: String
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .topLeading)  {
                
                // fish image
                Image(imageURL)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width)
                    .clipped()
                    .cornerRadius(30)
                
                // text overlay
                VStack(alignment: .leading, spacing: 2) {
                    Text(familyName)
                        .textstyles(.title2EmphasizedRounded)
                    Text(latinName)
                        .font(.caption)
                    
                }
                .padding(25)
                
                VStack {
                    Spacer()
                    HStack (spacing: 4){
                        Text("\(fishCount) fish detected")
                            .textstyles(.bodyMedium)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color(.white))
                            .foregroundColor(.blue)
                            .clipShape(Capsule())
                        
                        Spacer()
                    }
                    .padding(25)
                    
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(radius: 3)
        }
        .aspectRatio(1.2, contentMode: .fit)
        
    }
}


#Preview {
    FishFamilyCard(
        familyName: "Surgeonfish",
        latinName: "Acanthuridae",
        fishCount: 20,
        imageURL: "samplePicture",
    )
    .frame(width: 240, height: 200)
}

