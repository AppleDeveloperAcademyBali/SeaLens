//
//  UploadVideoPresentation.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 25/10/2025.
//

import SwiftUI


struct UploadVideoPresentation: View {
    
    @StateObject private var viewModel = UploadVideoViewModel()
    
    let suggestion = ["Bali", "Sydney", "Jakarta"]
    
    
    var body: some View {
        ZStack  {
            // white background
            Color.white.ignoresSafeArea()
            
            VStack() {
                VStack (alignment: .leading) {
                    
                    // top text
                    Text("Upload Video")
                        .textstyles(.title1Emphasized)
                    
                    Text("Choose a video file and upload to proceed.")
                        .textstyles(.title3Regular)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 10)
                    
                    ZStack {
                        // big box outline
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(style: StrokeStyle(lineWidth: 1))
                            .foregroundColor(.gray)
                        
                        GeometryReader { geometry in
                            
                            HStack(alignment: .top, spacing: 16)  {
                                
                                // LEFT SIDE: drag & drop box
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
                                                Text("MP4, AVI, MOV, WMV, and MKV formats, up to 50MB")
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
                                    .padding()
                                }
                                .padding()
                                .frame(width: geometry.size.width * 0.5)
                                
                                // RIGHT SIDE: enter information
                                VStack(alignment: .leading, spacing: 8){
                                    
                                    Text("File name")
                                        .textstyles(.caption1Regular)
                                    TextField("", text: $viewModel.fileName)
                                        .textFieldStyle(.roundedBorder)
                                        .frame(width: 220)
                                    
                                    Text("Location")
                                        .textstyles(.caption1Regular)
                                    ComboBox(text: $viewModel.location, values: suggestion)
                                        .frame(width: 220)
                                    
                                    Text("Site")
                                        .textstyles(.caption1Regular)
                                    ComboBox(text: $viewModel.site, values: suggestion)
                                        .frame(width: 220)
                                    
                                    Text("Transect")
                                        .textstyles(.caption1Regular)
                                    ComboBox(text: $viewModel.transect, values: suggestion)
                                        .frame(width: 220)
                                    
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
                                    Spacer()
                                    
                                    // original file name
                                    Text(viewModel.originalFileName.isEmpty ? "" : "Original file name")
                                        .textstyles(.caption1Regular)
                                    Text(viewModel.originalFileName.isEmpty ? "" : viewModel.originalFileName)
                                        .textstyles(.caption1Regular)
                                        .foregroundStyle(.secondary)
                                    
                                    // file duration
                                    Text(viewModel.fileDuration.isEmpty ? "" : "File duration")
                                        .textstyles(.caption1Regular)
                                    Text(viewModel.fileDuration.isEmpty ? "" : viewModel.fileDuration)
                                        .textstyles(.caption1Regular)
                                        .foregroundStyle(.secondary)
                                    
                                    
                                    
                                    // date taken
                                    Text(viewModel.date.isEmpty ? "" : "Date taken")
                                        .textstyles(.caption1Regular)
                                    Text(viewModel.date.isEmpty ? "" : viewModel.date)
                                        .textstyles(.caption1Regular)
                                        .foregroundStyle(.secondary)
                                    
                                    // file size
                                    Text(viewModel.fileSize.isEmpty ? "" : "File size")
                                        .textstyles(.caption1Regular)
                                    Text(viewModel.fileSize.isEmpty ? "" : viewModel.fileSize)
                                        .textstyles(.caption1Regular)
                                        .foregroundStyle(.secondary)
                                    
                                    
                                    Spacer()
                                    
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
                            .padding([.top, .bottom], 20)
                        }
                        .padding()
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 60)
            .padding(.vertical, 60)
        }
    }
}




#Preview {
    UploadVideoPresentation()
        .frame(width: 1000, height: 800)
}
