//
//  FileService.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 16/10/2025.
//

import Foundation
import ZipArchive


// MARK: - Custom Errors
enum FileServiceError: LocalizedError {
    case zipFileNotFound
    case extractionFailed(String)
    
    var errorDescription: String? {
        switch self {
        case .zipFileNotFound:
            return "Zip file not found."
        case .extractionFailed(let message):
            return "Extraction failed: \(message)"
        }
    }
}



// MARK: FileService Class
class FileService {
    
    
    
    // MARK: - Extract Zip File
    func extract(from zipURL: String, to destinationURL: String) async throws -> Bool {
        
        // validate the Zip File Exists
        guard FileManager.default.fileExists(atPath: zipURL) else {
            throw FileServiceError.zipFileNotFound
        }
        
        // creates destination folder before extracting
        try FileManager.default.createDirectory(
            atPath: destinationURL,
            withIntermediateDirectories: true,
            attributes: nil)
        
        // perform Extraction
        return try await withCheckedThrowingContinuation { continuation in
            
            // flag to prevent double-resume crashes
            var hasResumed = false
            
            _ = SSZipArchive.unzipFile(
                atPath: zipURL,
                toDestination: destinationURL,
                overwrite: true,
                password: nil,
                progressHandler: nil
            ) { _, succeeded, error in
                guard !hasResumed else { return }
                hasResumed = true
                
                if succeeded {
                    continuation.resume(returning: true)
                } else {
                    let message = error?.localizedDescription ?? "Unknown extraction error"
                    continuation.resume(throwing: FileServiceError.extractionFailed(message))
                }
                
            }
            
        }
        
    }
    
    
    // MARK: - Create A Unique Extraction Path
    func createUniqueExtractionPath() throws -> URL {
        
        // asking macOS where the application support directory
        let appSupport = FileManager.default.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        ) [0]
        
        // defines subfolder named "SeaLens" inside the application support directory
        let appDirectory = appSupport.appendingPathComponent("SeaLens")
        
        // creates the subfolder "SeaLens" if it doesn't exist
        try FileManager.default.createDirectory(
            at: appDirectory,
            withIntermediateDirectories: true,
            attributes: nil
            )
        
        // returns the URL of the where the new folder should be
        return appDirectory.appendingPathComponent("ExtractedImages_\(UUID().uuidString.prefix(8))")
    
    }
    
    
    
    
    
    
    
    
}

