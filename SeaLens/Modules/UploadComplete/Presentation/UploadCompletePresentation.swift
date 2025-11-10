//
//  UploadCompletePresentation.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 7/11/2025.
//


import SwiftUI



struct UploadCompletePresentation: View {
    
    @ObservedObject var viewModel: UploadVideoViewModel

        
    var body: some View {
        
        VStack (alignment: .leading, spacing: 1) {
            
            HStack {
                
                Text("Upload Complete")
                    .textstyles(.title1Emphasized)
                
                // video tag component
                VideoTag(fileName: viewModel.fileName)

            }
            
            HStack  {
                
                Spacer()
                
                Button {

                } label: {
                    Text("Review fish count")
                        .foregroundColor(.blue)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)

                }
                .cornerRadius(16)
                .buttonStyle(.glass)
                .shadow(radius: 2)

                Button {

                } label: {
                    Image("iconSort")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(.circle)
                }
                .buttonStyle(.plain)
                
                Button {
                    
                } label: {
                    Image("iconFilter")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(.circle)
                }
                .buttonStyle(.plain)
                
            }
            
            FishFamilyGrid()
            
            Spacer()
            
            
            
            
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 30)
        
        
    }
}



//#Preview {
//    UploadCompletePresentation(viewModel: UploadVideoViewModel())
//        .frame(width: 1200, height: 800)
//}
