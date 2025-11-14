//
//  UploadVideoData+File.swift
//  SeaLens
//
//  Created by Handy Handy on 08/11/25.
//

import Foundation
import AppKit

extension UploadVideoData {
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
}
