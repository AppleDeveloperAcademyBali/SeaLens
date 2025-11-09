//
//  UploadVideoPresentation.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 25/10/2025.
//

import SwiftUI


struct UploadVideoPresentation: View {
    
    @ObservedObject var viewModel: UploadVideoViewModel
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                
                // top text
                Text("Upload Video")
                    .textstyles(.title1Emphasized)
                Text("Choose a video file and upload to proceed.")
                    .textstyles(.title3Regular)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 10)
                
                // big box outline
                HStack(alignment: .top, spacing: 16)  {
                    
                    // LEFT SIDE: drag & drop box
                    FileUploadView(viewModel: viewModel)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    // RIGHT SIDE: enter information
                    FileFormView(viewModel: viewModel)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    
                }
                .padding()
                .fixedSize(horizontal: false, vertical: true)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle(lineWidth: 1))
                        .foregroundColor(.gray)
                        .opacity(0.5)
                }
            }
            .disabled(viewModel.isUploading)
            .padding(24)
            .padding(.horizontal,12)
        }
        
    }
}
