//
//  UploadVideoViewModel.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 27/10/2025.
//

import Foundation

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
    @Published var dateTaken = ""
    @Published var fileSize = ""
    
    private let domain = UploadVideoDomain()
    
    
    func selectFile() {
        
        if let result = domain.pickVideoAndExtractMetadata() {
            originalFileName = result.url.lastPathComponent
            fileDuration = result.duration
            dateTaken = result.dateTaken
//            fileSize = result.fileSize
        }
            
    }
    
}
