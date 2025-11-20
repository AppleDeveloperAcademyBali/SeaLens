//
//  ReviewFishPresentation.swift
//  SeaLens
//
//  Created by Handy Handy on 09/11/25.
//

import SwiftUI

struct FishReviewPresentation: View {
    @EnvironmentObject var router: NavigationRouter
    @StateObject private var viewModel = FishReviewViewModel()
    //
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                NavigationFishCountView {
                    router.dismissReviewFish()
                }
                .padding()
                FishFamiliesListView(viewModel: viewModel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: 360, maxHeight: .infinity)
            .glassEffect(in: .rect(cornerRadius: 16.0))
            .padding()
            
            AnnotatedVideoView()
                .padding(.vertical)
                .padding(.trailing)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .task {
            await self.viewModel.assignFootageUid(router.selectedFootageUid)
            await self.viewModel.getFishFamilies()
        }
    }
}

#Preview {
    FishReviewPresentation()
}
