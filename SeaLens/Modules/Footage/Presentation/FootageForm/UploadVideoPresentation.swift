//
//  UploadVideoPresentation.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 25/10/2025.
//

import SwiftUI
import SwiftData

struct UploadVideoPresentation: View {
    
    @StateObject var viewModel: UploadVideoViewModel
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresented: Bool
    @State private var navigateToComplete = false
    
    init(modelContext: ModelContext, isPresented: Binding<Bool>) {
        let dataService = DataService(modelContainer: modelContext.container)
        let uploadVideoData = UploadVideoData(dataService: dataService)
        let uploadVideoDomain = UploadVideoDomain(uploadVideoData: uploadVideoData)
        _viewModel = StateObject(wrappedValue: UploadVideoViewModel(uploadVideoDomain: uploadVideoDomain))
        _isPresented = isPresented
    }

    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                
                // top text
                HStack {
                    VStack (alignment: .leading) {
                        Text("Upload Video")
                            .textstyles(.title1Emphasized)
                        Text("Choose a video file and upload to proceed.")
                            .textstyles(.title3Regular)
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 10)
                    }
                    
                    Spacer()
                    
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .padding()
                    }
                    .clipShape(Circle())
                    .buttonStyle(.glass)

                }
                
                // big box outline
                HStack(alignment: .top, spacing: 16)  {
                    
                    // LEFT SIDE: drag & drop box
                    FileUploadView(viewModel: viewModel)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    // RIGHT SIDE: enter information
                    if viewModel.selectedFileURL != nil {
                        FileFormView(viewModel: viewModel)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    
                    
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
            .onChange(of: viewModel.uploadSucceded) { _, newValue in
                if newValue {
                    navigateToComplete = true
                }
            }
        }
//        .navigationDestination(isPresented: $navigateToComplete) {
//            if let footageUID = viewModel.uploadedFootageUID {
//                UploadCompletePresentation(
//                    viewModel: createUploadCompleteViewModel(for: footageUID)
//                )
//            }
//        }


    }
    
    private func createUploadCompleteViewModel(for footageUID: UUID) -> UploadCompleteViewModel {
        let dataService = DataService(modelContainer: modelContext.container)
        let footageData = FootageData(dataService: dataService)
        let domain = UploadCompleteDomain(footageData: footageData)
        return UploadCompleteViewModel(footageUID: footageUID, domain: domain)
    }
    
}
