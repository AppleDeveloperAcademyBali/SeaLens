//
//  FileService.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 16/10/2025.
//

import Foundation
/*
import ZipArchive


// MARK: - Custom Errors
enum FileServiceError: LocalizedError {
    case zipFileNotFound
    case extractionFailed(String)
    case fileNotFound
    case deletionFailed(String)
    case directoryCreationFailed(String)
    
    var errorDescription: String? {
        switch self {
        case .zipFileNotFound:
            return "Zip file not found."
        case .extractionFailed(let message):
            return "Extraction failed: \(message)"
        case .fileNotFound:
            return "File or folder not found."
        case .deletionFailed(let message):
            return "Failed to delete item: \(message)"
        case .directoryCreationFailed(let message):
            return "Failed to create directory: \(message)"
        }
    }
}



// MARK: - FileService Class
class FileService {
    
    // MARK: - Extract Zip File
    func extract(from zipURL: String, to destinationURL: String) async throws -> Bool {
        
        // validate the zip file exists
        guard FileManager.default.fileExists(atPath: zipURL) else {
            throw FileServiceError.zipFileNotFound
        }
        
        // creates destination folder before extracting
        do {
            try FileManager.default.createDirectory(
                atPath: destinationURL,
                withIntermediateDirectories: true,
                attributes: nil
            )
        } catch {
            throw FileServiceError.directoryCreationFailed(error.localizedDescription)
        }
        
        // perform extraction
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
        do {
            try FileManager.default.createDirectory(
                at: appDirectory,
                withIntermediateDirectories: true,
                attributes: nil
            )
        } catch {
            throw FileServiceError.directoryCreationFailed(error.localizedDescription)
        }
        
        // returns the URL of the where the new folder should be
        return appDirectory.appendingPathComponent("ExtractedImages_\(UUID().uuidString.prefix(8))")
    
    }
    
    
    // MARK: - Delete File or Folder
    func deleteItem(at url: URL) throws {
        
        let fileManager = FileManager.default
        
        // check if the file exists before deleting
        guard fileManager.fileExists(atPath: url.path) else {
            throw FileServiceError.fileNotFound
        }
        
        do {
            try fileManager.removeItem(at: url)
        } catch {
            throw FileServiceError.deletionFailed(error.localizedDescription)
        }
        
    }
    
    
    
    
    
    
    
    
    
}
 
 */

