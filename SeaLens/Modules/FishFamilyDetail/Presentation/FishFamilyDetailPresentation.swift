//
//  FishFamilyDetailPresentation.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 14/11/2025.
//


import SwiftUI
import SwiftData

struct FishFamilyDetailPresentation: View {
    
    @StateObject private var viewModel: FishFamilyDetailViewModel
    @Environment(\.modelContext) private var modelContext
    
    init(viewModel: FishFamilyDetailViewModel) {
        _viewModel = StateObject(
            wrappedValue: viewModel
        )
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let fishFamily = viewModel.fishFamily {
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(fishFamily.fishFamilyReference?.commonName ?? "")
                                .textstyles(.largeTitleEmphasized)
                            
                            Text("(\(fishFamily.fishFamilyReference?.latinName ?? ""))")
                                .textstyles(.bodyRegular)
                        }
                        
                        Text("\(fishFamily.numOfFishDetected) photos")
                            .textstyles(.title3Regular)
                    }
                    
//                    FishFamilyDetailGrid(fish: fishFamily.fish)
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 30)
                
            } else {
                VStack(spacing: 12) {
                    Text("Fish family not found")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            if viewModel.domain == nil {
                viewModel.domain = FishFamilyDetailDomain(modelContext: modelContext)
            }
            viewModel.load()
        }
    }
}


//#Preview {
//    FishFamilyDetailPresentation(fishFamilyID: Footage.sampleData[9].fishFamily.first!.uid)
//        .frame(width: 1200, height: 800)
//}
