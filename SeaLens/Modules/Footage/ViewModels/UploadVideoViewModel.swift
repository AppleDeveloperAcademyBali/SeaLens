//
//  UploadVideoViewModel.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 27/10/2025.
//

import Foundation
import AVFoundation
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
        
    let domain: UploadVideoDomain
    var selectedFileURL: URL?
    
    init(uploadVideoDomain: UploadVideoDomain) {
        self.domain = uploadVideoDomain
        self.createLocationSuggestions()
        self.createSiteSuggestions()
        self.createTransectSuggestions()
    }
    
    // MARK: - Assign Metadata to the view
    func applyMetadata(_ result: (url: URL, duration: String, date: String, fileSize: String)) {
        originalFileName = result.url.lastPathComponent
        fileDuration = result.duration
        date = result.date
        fileSize = result.fileSize
        selectedFileURL = result.url
    }
    
    // MARK: - Add Tags
    func addTag() {
        tags.append(newTag)
        newTag = ""
    }
    
    // MARK: - Remove Tags
    func removeTag(_ removedTag: String) {
        tags.removeAll { tag in
            removedTag == tag
        }
    }
    
    // MARK: - Upload Video
    func uploadSelectedVideo() {
        
        // make sure file is selected
        guard let fileURL = selectedFileURL else {
            uploadStatusMessage = "Upload Failed: Please select a video"
            return
        }
        
        // validation of the data
        if fileName.isEmpty { uploadStatusMessage = "Upload Failed: File name is required" ; return }
        if location.isEmpty { uploadStatusMessage = "Upload Failed: Location is required" ; return }
        if site.isEmpty { uploadStatusMessage = "Upload Failed: Site is required" ; return }
        if transect.isEmpty { uploadStatusMessage = "Upload Failed: Transect is required" ; return }
        if depth.isEmpty {
            uploadStatusMessage = "Upload Failed: Depth is required" ; return
        } else if !depth.isNumeric() { uploadStatusMessage = "Upload Failed: Depth should numeric" ; return }
        
        
        isUploading = true                              // triggers progress bar
        uploadProgress = 0                              // reset progress to 0
        uploadStatusMessage = "Uploading..."            // update essage shown in UI
        
        //TODO: Move it to success when testing with Server
        var timerCount: Int = 5
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in

            timerCount -= 1
            Task { @MainActor in
                self.uploadProgress += 0.25
            }
            if timerCount == 0 {
                timer.invalidate()
                Task { @MainActor in
                    self.saveVideoToLocalStorage()
                    self.isUploading = false
                    self.uploadStatusMessage = "Upload data successfully"
                }
            }
        }
        return
        
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
                    self?.saveVideoToLocalStorage()
                case.failure(let error):
                    self?.uploadStatusMessage = "Upload Failed: \(error.localizedDescription)"
                }
            }
            
        })
        
    }
    
    //MARK: - Save Footage to Local Storage
    func saveVideoToLocalStorage() {
        Task(priority: .utility) {
            await self.domain.setFootage(footage: createFootage())
        }
    }
    
}
