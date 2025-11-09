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
        ZStack (alignment: .topLeading) {
            Image("samplePicture")
                .resizable()
                .frame(width: 340, height: 200)
                .clipShape(
                    RoundedRectangle(cornerRadius: 16)
                )
            VStack (alignment: .leading) {
                VStack (alignment: .leading) {
                    Text("Surgeonfish")
                        .textstyles(.title3Regular)
                    Text("Acanthuridae")
                        .textstyles(.bodyRegular)
                }
                .padding(10)
                .background(Color.black.opacity(0.3))
                .cornerRadius(16)
                
                Spacer()
                
                //TODO: - Why do we need to xmark on the TextField
                TextField(text: $totalFish) {
                }
                .multilineTextAlignment(.trailing)
                .frame(width: 80)
            }
            .padding(20)
        }
        .frame(width: 340, height: 200)
    }
}

#Preview {
    ReviewFishComponent()
}
