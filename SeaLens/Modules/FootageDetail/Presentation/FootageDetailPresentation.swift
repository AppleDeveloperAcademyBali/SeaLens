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
                VStack(alignment: .leading, spacing: 20) {                    
                    FootageDetailHeaderView(
                        footageDetailViewModel: viewModel
                    )
                    
                    FishFamilyGrid(fishFamilies: viewModel.fishFamilies)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding()
        .navigationTitle(viewModel.footage?.filename ?? "")
        .task {
            await viewModel.loadData()
        }
        .onChange(of: viewModel.footage) { _, newValue in
            Task {
                await viewModel.loadData()
            }
        }
        .onChange(of: viewModel.searchText) { _, newValue in
            viewModel.applySearching()
        }
        .toolbar {
            ToolbarItem {
                Button {
                    initialNavigationViewModel.showingReviewFish()
                } label: {
                    Text("Review fish count")
                }
                .buttonStyle(.glass)
            }
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
