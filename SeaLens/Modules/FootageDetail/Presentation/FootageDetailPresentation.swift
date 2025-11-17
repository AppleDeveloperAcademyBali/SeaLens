//
//  UploadCompletePresentation.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 7/11/2025.
//


import SwiftUI
import SwiftData

struct FootageDetailPresentation: View {
    @ObservedObject var viewModel: FootageDetailViewModel
    
    var body: some View {
        HStack {
            if viewModel.footageUIDString == "" {
                loadingView
            }else {
                VStack(alignment: .leading, spacing: 1) {                    
                    FootageDetailHeaderView(footageDetailViewModel: viewModel)
                    
                    FishFamilyGrid(fishFamilies: viewModel.fishFamilies)

                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding()
        .navigationTitle(viewModel.footage?.filename ?? "No Footage")
//        .navigationDestination(for: UUID.self) { familyID in
//            FishFamilyDetailPresentation(
//                viewModel: createFishFamilyDetailViewModel(for: familyID))
//            
//        }
        .onAppear {
            viewModel.loadFootage()
        }

    }
    
    var loadingView: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
            Text("Loading...")
        }
    }
    
}
