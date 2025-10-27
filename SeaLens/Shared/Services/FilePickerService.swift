//
//  FilePickerService.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 27/10/2025.
//

import AppKit

final class FilePickerService {
    
    //
    static func pickVideo() -> URL? {
        
        let panel = NSOpenPanel()
        panel.title = "Select a Video File"
        panel.allowedContentTypes = [.movie]        // only allows choosing movies
        panel.allowsMultipleSelection = false       // only allows choosing one file
        panel.canChooseFiles = true                 // allows choosing files
        panel.canChooseDirectories = false          // cannot choose directories
        
        // show the finder panel as a modal window
        let response = panel.runModal()
        if response == .OK  {
            return panel.url
        }   else {
            return nil
        }
        
    }
    
}
