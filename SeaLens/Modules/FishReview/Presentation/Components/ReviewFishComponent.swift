//
//  ReviewFishComponent.swift
//  SeaLens
//
//  Created by Handy Handy on 09/11/25.
//

import SwiftUI

struct ReviewFishComponent: View {
    @State private var totalFish: String = "1.201"
    
    var body: some View {
        VStack (spacing: 0) {
            Image("samplePicture")
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 145)
                .clipped()
            HStack {
                VStack (alignment: .leading) {
                    Text("Surgeonfish")
                        .textstyles(.title2Regular)
                        .padding(.bottom, 2)
                    Text("Acanthuridae")
                        .textstyles(.bodyRegular)
                }
                
                Spacer()
                
                VStack (alignment: .trailing) {
                    Text("Fish count")
                        .textstyles(.caption1Regular)
                        .opacity(0.6)
                    
                    TextField(text: $totalFish) {
                    }
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
    }
}

#Preview {
    ReviewFishComponent()
}
