//
//  FishFamilyCard.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 03/11/25.
//

import SwiftUI

struct FishFamilyAssignCard: View {
    let fishFamilyRef: FishFamilyReference
    let fishFamilyConfidenceValue: Double

    @Binding var selectedFishFamily: FishFamilyReference?
    
    var body: some View {
        HStack {
            Rectangle()
                .foregroundStyle(.gray.opacity(0.1))
                .cornerRadius(20)
                .overlay {
                    
                    Image(getImageUrl(fishFamilyRef: fishFamilyRef))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 144, height: 144)

                }
                .frame(width: 178, height: 178)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(fishFamilyRef.commonName)
                        .font(.title2)
                        .bold()
                    Text("(\(fishFamilyRef.latinName))")
                        .font(.caption)
                        .italic()
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.right")
                    }
                }
                
                Text("\(fishFamilyRef.fishSpeciesReferences?.count) species")
                    .font(.subheadline)
                
                Text("")
                
                Text("\(String(format: "%.2f", fishFamilyConfidenceValue))% match")
                    .foregroundColor(.green)
                    .font(.headline)
            }
            .padding()
            
            Spacer()
            
            Button("Assign to this family") {
                selectedFishFamily = fishFamilyRef
            }
            .foregroundStyle(.blue)
            .buttonStyle(.glass)
            .cornerRadius(100)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            
        }
        .frame(width: 1000, height: 178)
    }
    
    func getImageUrl(fishFamilyRef: FishFamilyReference) -> String {
        var imageUrl: String = "noImage"
        
        if let firstSpecies = fishFamilyRef.fishSpeciesReferences?.first {
            imageUrl = firstSpecies.imageUrl
        } else {
            imageUrl = "noImage"
        }
        
        return imageUrl
    }
}

#Preview {
    FishFamilyAssignCard(fishFamilyRef: FishFamilyReference(latinName: "Chaetodondidae", commonName: "Butterflyfish", imageUrl: "samplePicture", sourceUrl: "https://www.fishbase.org.au/v4/summary/8014", attribution: "Froese, R. and D. Pauly. Editors. 2025. FishBase. World Wide Web electronic publication. www.fishbase.org, version (04/2025)"), fishFamilyConfidenceValue: 95.0, selectedFishFamily: .constant(nil))
}
