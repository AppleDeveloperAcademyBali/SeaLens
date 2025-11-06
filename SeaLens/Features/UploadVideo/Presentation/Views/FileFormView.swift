//
//  FileFormView.swift
//  SeaLens
//
//  Created by Handy Handy on 06/11/25.
//

import SwiftUI

struct FileFormView: View {
    @ObservedObject var viewModel: UploadVideoViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text("File name")
                .textstyles(.caption1Regular)
            TextField("", text: $viewModel.fileName)
                .textFieldStyle(.roundedBorder)
                .frame(width: 220)
                .padding(.bottom, 8)
            
            DropdownFieldComponent(
                title: "Location",
                suggestion: viewModel.locationSuggestion,
                selectedItem: $viewModel.location
            )
            .padding(.bottom, 8)
            
            DropdownFieldComponent(
                title: "Site",
                suggestion: viewModel.siteSuggestion,
                selectedItem: $viewModel.site
            )
            .padding(.bottom, 8)
            
            DropdownFieldComponent(
                title: "Transect",
                suggestion: viewModel.transectSuggestion,
                selectedItem: $viewModel.transect
            )
            .padding(.bottom, 8)
            
            Text("Depth")
                .textstyles(.caption1Regular)
            ZStack(alignment: .trailing)  {
                TextField("", text: $viewModel.depth)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 220)
                    .padding(.trailing, 20)
                Text("m")
                    .foregroundStyle(.secondary)
                    .padding(.trailing, 30)
            }
            .padding(.bottom, 8)
            
            if viewModel.originalFileName.isEmpty {
                EmptyView()
            }else {
                // original file name
                MetadataDetailComponent(
                    title: "Original file name",
                    subtitle: viewModel.originalFileName
                )
            }
            
            if viewModel.fileDuration.isEmpty {
                EmptyView()
            }else {
                // original file name
                MetadataDetailComponent(
                    title: "File Duration",
                    subtitle: viewModel.fileDuration
                )
            }
            
            if viewModel.date.isEmpty {
                EmptyView()
            }else {
                // original file name
                MetadataDetailComponent(
                    title: "Data taken",
                    subtitle: viewModel.date
                )
            }
            
            if viewModel.fileSize.isEmpty {
                EmptyView()
            }else {
                // original file name
                MetadataDetailComponent(
                    title: "File size",
                    subtitle: viewModel.fileSize
                )
            }
            
            // upload and process button
            if viewModel.isUploading {
                VStack {
                    ProgressView(value: viewModel.uploadProgress)
                        .progressViewStyle(.linear)
                        .frame(width: 220)
                    Text("\(Int(viewModel.uploadProgress * 100))%")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                
            } else {
                Button {
                    viewModel.uploadSelectedVideo()
                } label: {
                    Text("Upload and process file")
                        .textstyles(.bodyEmphasized)
                }
                .buttonStyle(.glass)
                
                if !viewModel.uploadStatusMessage.isEmpty {
                    Text(viewModel.uploadStatusMessage)
                        .font(.footnote)
                        .foregroundColor(viewModel.uploadStatusMessage.contains("failed") ? .red: .green)
                        .padding(.top, 8)
                    
                }
                
            }
        }
    }
}

#Preview {
    FileFormView(viewModel: UploadVideoViewModel())
}
