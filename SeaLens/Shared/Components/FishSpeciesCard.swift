//
//  FishSpeciesCard.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 03/11/25.
//

import SwiftUI

struct FishSpeciesCard: View {
    let fishSpecies: FishSpeciesReference
    
    let inchMultiplier: Double = 0.393701
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(32)
                .foregroundColor(.gray.opacity(0.1))
            
            VStack(alignment: .leading) {
                Image(fishSpecies.imageUrl)
                    .resizable()
                    .frame(height: 185)
                    .scaledToFit()
                    .cornerRadius(20)
                    .padding(.bottom, 20)
                
                Text(fishSpecies.latinName)
                    .bold()
                    .italic()
                    .lineHeight(.loose)
                
                Text(fishSpecies.commonName)
                    .italic()
                    .lineHeight(.loose)
                    .padding(.bottom, 15)
                
                Text(fishSpecies.identification)
                    .lineLimit(5, reservesSpace: true)
                    .padding(.bottom, 15)
                
                Text("LOCATION")
                    .font(.subheadline)
                Text(fishSpecies.location)
                    .lineLimit(3, reservesSpace: true)
                    .padding(.bottom, 15)
                
                Text("SIZE")
                    .font(.subheadline)
                Text("to \(String(format: "%.2f", fishSpecies.maxSizeInCm)) cm (\(String(format: "%.2f", (fishSpecies.maxSizeInCm * inchMultiplier)))) in length")
                
                Spacer()
                
                Button("Assign to this species") {
                    
                }
                    .foregroundStyle(.blue)
                    .buttonStyle(.glass)
                    .cornerRadius(100)
            }
            .padding()
        }
        .frame(width: 330, height: .infinity)
    }
}

#Preview {
    FishSpeciesCard(fishSpecies: FishSpeciesReference.sampleData[0])
}
