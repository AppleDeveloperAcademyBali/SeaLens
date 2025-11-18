//
//  UploadCompletePresentation.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 7/11/2025.
//


import SwiftUI
import SwiftData

struct FootageDetailPresentation: View {
    @StateObject var viewModel = FootageDetailViewModel()
    
    var body: some View {
        VStack {
            if viewModel.footageUIDString == "" {
                loadingView
            }else {
                VStack(alignment: .leading, spacing: 1) {
                    FootageDetailHeaderView(FootageDetailViewModel: viewModel)
                    
                    FishFamilyGrid(fishFamilies: viewModel.fishFamilies)

                    Spacer()
                }
            }
        }
        .background(.blue)
//        .navigationDestination(for: UUID.self) { familyID in
//            FishFamilyDetailPresentation(
//                viewModel: createFishFamilyDetailViewModel(for: familyID))
//            
//        }
        
//        .padding(30)
//        .onAppear {
//            viewModel.loadFootage()
//        }

    }
    
    var loadingView: some View {
        VStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
            Text("Loading...")
            Spacer()
        }
        .frame(width: 100, height: 100)
        .background(.red)
    }
    
}
