//
//  UploadVideoData.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 27/10/2025.
//

import AppKit

struct UploadVideoData {
    
    // function to pick video from finder
    func pickVideoFromFinder() -> URL? {
        
        let panel = NSOpenPanel()
        panel.title = "Select a Video File"
        panel.allowedContentTypes = [.movie]        // only allows choosing movies
        panel.allowsMultipleSelection = false       // only allows choosing one file
        panel.canChooseFiles = true                 // allows choosing files
        panel.canChooseDirectories = false          // cannot choose directories
        

        if panel.runModal() == .OK {
            return panel.url
        }
        return nil
        
    }
    
}
