//
//  UploadVideoViewModel.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 27/10/2025.
//

import Foundation
import UniformTypeIdentifiers

@MainActor
final class UploadVideoViewModel: ObservableObject {
    
    // MARK: - published properties for the view
    
    // state variables
    @Published var fileName = ""
    //
    @Published var location = ""
    @Published var locationSuggestion: [String] = []
    @Published var site = ""
    @Published var siteSuggestion: [String] = []
    @Published var transect = ""
    @Published var transectSuggestion: [String] = []
    //
    @Published var depth = ""
    //
    @Published var addTagPressed: Bool = false
    @Published var newTag = ""
    @Published var tags: [String] = []
    //
    @Published var originalFileName = ""
    @Published var fileDuration = ""
    @Published var date = ""
    @Published var fileSize = ""
    //
    @Published var uploadProgress: Double = 0
    @Published var isUploading: Bool = false
    @Published var uploadStatusMessage: String = ""
        
    private let domain = UploadVideoDomain()
    private var selectedFileURL: URL?
    
    
    private func applyMetadata(_ result: (url: URL, duration: String, date: String, fileSize: String)) {
        originalFileName = result.url.lastPathComponent
        fileDuration = result.duration
        date = result.date
        fileSize = result.fileSize
        selectedFileURL = result.url
    }
    
    
    
    // MARK: - Select File
    func handleFileSelection()  {
        Task    {
            if let result = await self.domain.pickVideoAndExtractMetadata() {
                self.applyMetadata(result)
            }
        }
    }
    
    
    // MARK: - File Drop
    func handleFileDrop(providers: [NSItemProvider]) -> Bool {
        
        for provider in providers {
            
            if provider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
                provider.loadItem(forTypeIdentifier: UTType.movie.identifier, options: nil) { item, _ in
                    if let url = item as? URL {
                        Task { @MainActor in
                            if let result = await self.domain.extractMetadata(from: url) {
                                self.applyMetadata(result)
                            }
                        }
                    }
                    
                }
                return true
            }
        }
        return false
    }
    
    
    // MARK: - Upload Video
    func uploadSelectedVideo() {
        
        // make sure file is selected
        guard let fileURL = selectedFileURL else {
            uploadStatusMessage = "Please select a video"
            return
        }
        
        
        isUploading = true                              // triggers progress bar
        uploadProgress = 0                              // reset progress to 0
        uploadStatusMessage = "Uploading..."            // update essage shown in UI
        
        domain.uploadVideo(fileURL: fileURL, progress: { [weak self] progress in
            DispatchQueue.main.async {
                self?.uploadProgress = progress
            }
        }, completion: { [weak self] result in
            DispatchQueue.main.async {
                self?.isUploading = false
                switch result {
                case.success(let message):
                    self?.uploadStatusMessage = message
                    
                case.failure(let error):
                    self?.uploadStatusMessage = "Upload Failed: \(error.localizedDescription)"
                }
            }
            
        })
        
    }
    
    // MARK: - Add Tags
    func addTag() {
        tags.append(newTag)
    }
    
    // MARK: - Remove Tags
    func removeTag(_ removedTag: String) {
        tags.removeAll { tag in
            removedTag == tag
        }
    }
}
