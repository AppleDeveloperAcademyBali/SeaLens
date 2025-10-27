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
                                    
                                    VStack (spacing: 15) {
                                        
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
                                            viewModel.selectFile()
                                        }
                                        .buttonStyle(.glass)
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
                                    
                                    Text("Original file name")
                                    Text(viewModel.originalFileName.isEmpty ? "-" : viewModel.originalFileName)
                                        .foregroundStyle(.secondary)

                                    
                                    Text("File duration")
                                    Text(viewModel.fileDuration.isEmpty ? "-" : viewModel.fileDuration)
                                        .foregroundStyle(.secondary)

                                    
                                    Text("Date taken")
                                    Text(viewModel.dateTaken.isEmpty ? "-" : viewModel.dateTaken)
                                        .foregroundStyle(.secondary)

                                    
                                    Spacer()

                                    
                                }
                                .padding(.top, 20)
                                
                            }
                            .padding()
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 40)
            }
        }
    }
}



#Preview {
    UploadVideoPresentation()
        .frame(width: 1000, height: 700)
}
