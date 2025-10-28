//
//  UploadVideoViewModel.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 27/10/2025.
//

import Foundation

@MainActor
final class UploadVideoViewModel: ObservableObject {
    
    // published properties for the view
    
    // state variables
    @Published var fileName = ""
    @Published var location = ""
    @Published var site = ""
    @Published var transect = ""
    @Published var depth = ""
    
    @Published var originalFileName = ""
    @Published var fileDuration = ""
    @Published var date = ""
    @Published var fileSize = ""
    
    private let domain = UploadVideoDomain()
    
    func selectFile() {
        Task {
            if let result = await domain.pickVideoAndExtractMetadata() {
                originalFileName = result.url.lastPathComponent
                fileDuration = result.duration
                date = result.date
                fileSize = result.fileSize
            }
        }
    }
    
    
    
    
}
