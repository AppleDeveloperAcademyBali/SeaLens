//
//  FishFamilyDetailPresentation.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 14/11/2025.
//

import SwiftUI

struct FishFamilyDetailPresentation: View {
    
    let fishFamily: FishFamily
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 1) {
            
            HStack  {
                Text(fishFamily.fishFamilyReference?.commonName ?? "")
                    .textstyles(.largeTitleEmphasized)
                
                Text("(\(fishFamily.fishFamilyReference?.latinName ?? ""))")
                    .textstyles(.bodyRegular)
                
            }
            
            Text("\(fishFamily.numOfFishDetected) photos")
                .textstyles(.title3Regular)
            
                
            FishFamilyDetailGrid(fish: fishFamily.fish)

        
            
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 30)
    }
}
    

#Preview {
    FishFamilyDetailPresentation(fishFamily: Footage.sampleData[9].fishFamily.first!)
        .frame(width: 1200, height: 800)
}
