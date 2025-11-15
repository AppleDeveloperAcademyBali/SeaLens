//
//  UploadCompletePresentation.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 7/11/2025.
//


import SwiftUI
import SwiftData



struct UploadCompletePresentation: View {
    @StateObject var viewModel: UploadCompleteViewModel
    @Environment(\.modelContext) private var modelContext
    
    
    var body: some View {

        VStack(alignment: .leading, spacing: 1) {
            
            HStack {
                Text("Upload Complete")
                    .textstyles(.title1Emphasized)

                if let name = viewModel.footage?.filename  {
                    VideoTag(fileName: name)
                }
            }

            HStack {
                Spacer()
                Button { } label: {
                    Text("Review fish count")
                        .foregroundColor(.blue)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.glass)

                Button { } label: {
                    Image("iconSort")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(.circle)
                }
                .buttonStyle(.plain)

                Button { } label: {
                    Image("iconFilter")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(.circle)
                }
                .buttonStyle(.plain)
            }

            FishFamilyGrid(fishFamilies: viewModel.fishFamilies)

            Spacer()
        }
//        .navigationDestination(for: UUID.self) { familyID in
//            FishFamilyDetailPresentation(
//                viewModel: createFishFamilyDetailViewModel(for: familyID))
//            
//        }
        
        .padding(.horizontal, 30)
        .padding(.vertical, 30)
        .onAppear {
            viewModel.loadFootage()
        }

    }
    

}
