//
//  ReviewFishComponent.swift
//  SeaLens
//
//  Created by Handy Handy on 09/11/25.
//

import SwiftUI

struct ReviewFishComponent: View {
    @ObservedObject var fishReviewViewModel: FishReviewViewModel
    @Binding var fishFamily: FishFamily
    
    var body: some View {
        VStack (spacing: 0) {
            //TODO: - Do we need thumbnail for this?
            Image("\(fishFamily.fishes.first?.fishImages.first?.url ?? "samplePicture")")
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 145)
                .clipped()
            HStack {
                VStack (alignment: .leading) {
                    Text("\(fishFamily.fishFamilyReference?.commonName ?? "Common Name Not Found")")
                        .textstyles(.title2Regular)
                        .padding(.bottom, 2)
                    Text("\(fishFamily.fishFamilyReference?.latinName ?? "Common Name Not Found")")
                        .textstyles(.bodyRegular)
                }
                
                Spacer()
                
                VStack (alignment: .trailing) {
                    Text("Fish count")
                        .textstyles(.caption1Regular)
                        .opacity(0.6)
                    
                    TextField("", value: $fishFamily.numOfFishDetected, formatter: NumberFormatter())
                    .multilineTextAlignment(.trailing)
                    .frame(width: 80)
                }
            }
            .padding()
        }
        .frame(width: 300)
        .roundedCorners(radius: 16, corners: .allCorners)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("borderColor"), lineWidth: 1)
        )
        .onChange(of: fishFamily.numOfFishDetected) { _, newValue in
            Task {
                await fishReviewViewModel.updateFishFamilies(fishFamily)
            }
        }
    }
}
