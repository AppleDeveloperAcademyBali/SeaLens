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
                        .font(.title)
                        .bold()
                    
                    Text("Choose a video file and upload to proceed.")
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
                                                    .font(.headline)
                                                Text("MP4, AVI, MOV, WMV, and MKV formats, up to 50MB")
                                                    .font(.footnote)
                                                    .foregroundStyle(.secondary)
                                            }
                                            
                                            // select a file button
                                            Button("Select a file") {
                                                viewModel.handleFileSelection()
                                            }
                                            .buttonStyle(.glass)
                                            
                                        } else {
                                            
                                            Image(systemName: "checkmark.circle.fill")
                                                .font(.system(size: 40))
                                                .foregroundColor(.green)
                                            
                                                Text(viewModel.originalFileName)
                                                    .font(.headline)
 
                                            // select a file button
                                            Button("Select a different file") {
                                                viewModel.handleFileSelection()
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
                                    TextField("", text: $viewModel.fileName)
                                        .textFieldStyle(.roundedBorder)
                                        .frame(width: 220)
                                    
                                    Text("Location")
                                    ComboBox(text: $viewModel.location, values: suggestion)
                                        .frame(width: 220)
                                    
                                    Text("Site")
                                    ComboBox(text: $viewModel.site, values: suggestion)
                                        .frame(width: 220)
                                    
                                    Text("Transect")
                                    ComboBox(text: $viewModel.transect, values: suggestion)
                                        .frame(width: 220)
                                    
                                    Text("Depth")
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
                                    Text(viewModel.originalFileName.isEmpty ? "" : viewModel.originalFileName)
                                        .foregroundStyle(.secondary)

                                    // file duration
                                    Text(viewModel.fileDuration.isEmpty ? "" : "File duration")
                                    Text(viewModel.fileDuration.isEmpty ? "" : viewModel.fileDuration)
                                        .foregroundStyle(.secondary)

                                    
                                    // date taken
                                    Text(viewModel.date.isEmpty ? "" : "Date taken")
                                    Text(viewModel.date.isEmpty ? "" : viewModel.date)
                                        .foregroundStyle(.secondary)
                                    
                                    // file size
                                    Text(viewModel.fileSize.isEmpty ? "" : "File size")
                                    Text(viewModel.fileSize.isEmpty ? "" : viewModel.fileSize)
                                        .foregroundStyle(.secondary)

                                    
                                    Spacer()
                                    
                                    // upload and process button
                                    Button("Upload and process file") {
                                        
                                    }
                                    .buttonStyle(.glass)
                                    
                                    

                                    
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
}



#Preview {
    UploadVideoPresentation()
        .frame(width: 1000, height: 800)
}
