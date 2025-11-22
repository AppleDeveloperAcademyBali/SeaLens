//
//  FileUploadView.swift
//  SeaLens
//
//  Created by Handy Handy on 06/11/25.
//

import SwiftUI

struct FileUploadView: View {
    @ObservedObject var viewModel: UploadVideoViewModel
    
    var body: some View {
        ZStack  {
            // drag & drop box outline
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [8]))
                .foregroundColor(.gray.opacity(0.4))
                .onDrop(of: ["public.movie"], isTargeted: nil)  { providers in
                    viewModel.handleFileDrop(providers: providers)
                }

            
            VStack (spacing: 15) {
                
                if viewModel.originalFileName.isEmpty {
                    
                    // upload icon
                    Image(systemName: "tray.and.arrow.up.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                    
                    VStack(spacing: 3) {
                        Text("Drag & drop or select a file")
                            .textstyles(.title2Regular)
                        Text("MP4, AVI, MOV, WMV, and MKV formats")
                            .textstyles(.bodyRegular)
                            .foregroundStyle(.secondary)
                    }
                    
                    // select a file button
                    Button {
                        viewModel.handleFileSelection()
                    } label: {
                        Text("Select a file")
                            .textstyles(.bodyEmphasized)
                    }
                    .buttonStyle(.glass)
                    
                } else {
                    
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.green)
                    
                    Text(viewModel.originalFileName)
                        .textstyles(.title2Regular)
                    
                    // select a file button
                    Button  {
                        viewModel.handleFileSelection()
                    } label: {
                        Text("Select a different file")
                            .textstyles(.bodyEmphasized)
                    }
                    .buttonStyle(.glass)
                    
                }
                
            }
            .frame(minHeight: 520)
            .padding()
        }
    }
}
