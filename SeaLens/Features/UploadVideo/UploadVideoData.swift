//
//  UploadVideoData.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 27/10/2025.
//

import AppKit

struct UploadVideoData {
    
    private let networkService: NetworkService
    
    
    // function to pick video from finder
    @MainActor
    func pickVideoFromFinder() -> URL? {
        
        let panel = NSOpenPanel()
        panel.title = "Select a Video File"
        panel.allowedContentTypes = [.movie]        // only allows choosing movies
        panel.allowsMultipleSelection = false       // only allows choosing one file
        panel.canChooseFiles = true                 // allows choosing files
        panel.canChooseDirectories = false          // cannot choose directories
        

        return panel.runModal() == .OK ? panel.url : nil
        
    }
    
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func upload(fileURL: URL,
                progress: @escaping (Double) -> Void,
                completion: @escaping (Result<String, Error>) -> Void) {
        networkService.uploadVideo(fileURL: fileURL, progress: progress, completion: completion)
    }
    
    
    
}
