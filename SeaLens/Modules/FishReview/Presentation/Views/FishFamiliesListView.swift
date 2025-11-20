//
//  FishFamiliesListView.swift
//  SeaLens
//
//  Created by Handy Handy on 09/11/25.
//

import SwiftUI

struct FishFamiliesListView: View {
    @ObservedObject var viewModel: FishReviewViewModel
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            ForEach($viewModel.fishFamilies) { $fishFamily in
                ReviewFishComponent(
                    fishReviewViewModel: viewModel,
                    fishFamily: $fishFamily
                )
                    .padding(.bottom, 16)
            }
        }
        .frame(width: 360)
    }
}
