//
//  UploadVideoViewModel+File.swift
//  SeaLens
//
//  Created by Handy Handy on 07/11/25.
//

import Foundation
import UniformTypeIdentifiers

extension UploadVideoViewModel {
    
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
}
