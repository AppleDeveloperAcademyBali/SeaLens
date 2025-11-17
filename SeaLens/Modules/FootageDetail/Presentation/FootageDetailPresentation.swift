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
    @ObservedObject var initialNavigationViewModel: InitialNavigationViewModel
    
    var body: some View {
        HStack {
            if viewModel.footageUIDString == "" {
                loadingView
            }else {
                VStack(alignment: .leading, spacing: 1) {                    
                    FootageDetailHeaderView(
                        footageDetailViewModel: viewModel,
                        initialNavigationViewModel: initialNavigationViewModel
                    )
                    
                    FishFamilyGrid(fishFamilies: viewModel.fishFamilies)

                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding()
        .navigationTitle(viewModel.footage?.filename ?? "")
        .onAppear {
            viewModel.loadFootage()
        }
        .onChange(of: viewModel.footage) { _, newValue in
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
