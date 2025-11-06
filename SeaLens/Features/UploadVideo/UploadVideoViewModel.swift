//
//  UploadVideoViewModel.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 27/10/2025.
//

import Foundation

<<<<<<< HEAD
=======
@MainActor
>>>>>>> main
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
<<<<<<< HEAD
    @Published var dateTaken = ""
=======
    @Published var date = ""
>>>>>>> main
    @Published var fileSize = ""
    
    private let domain = UploadVideoDomain()
    
<<<<<<< HEAD
    
    func selectFile() {
        
        if let result = domain.pickVideoAndExtractMetadata() {
            originalFileName = result.url.lastPathComponent
            fileDuration = result.duration
            dateTaken = result.dateTaken
//            fileSize = result.fileSize
        }
            
    }
    
=======
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
    
    
    
    
>>>>>>> main
}
