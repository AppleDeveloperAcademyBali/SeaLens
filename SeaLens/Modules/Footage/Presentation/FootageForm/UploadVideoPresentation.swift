//
//  UploadVideoPresentation.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 25/10/2025.
//

import SwiftUI


struct UploadVideoPresentation: View {
    
    @ObservedObject var viewModel: UploadVideoViewModel
    @Environment(\.modelContext) private var modelContext
    @State private var navigateToComplete = false

    
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
            .onChange(of: viewModel.uploadSucceded) { _, newValue in
                if newValue {
                    navigateToComplete = true
                }
            }
        }
        .navigationDestination(isPresented: $navigateToComplete) {
            if let footageUID = viewModel.uploadedFootageUID {
                UploadCompletePresentation(
                    viewModel: createUploadCompleteViewModel(for: footageUID)
                )
            }
        }


    }
    
    private func createUploadCompleteViewModel(for footageUID: UUID) -> UploadCompleteViewModel {
        let dataService = DataService(modelContainer: modelContext.container)
        let footageData = FootageData(dataService: dataService)
        let domain = UploadCompleteDomain(footageData: footageData)
        return UploadCompleteViewModel(footageUID: footageUID, domain: domain)
    }


    
    
}
