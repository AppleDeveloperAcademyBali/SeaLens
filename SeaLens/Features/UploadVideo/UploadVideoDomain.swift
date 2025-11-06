//
//  UploadVideoDomain.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 27/10/2025.
//

import Foundation
import AVFoundation

struct UploadVideoDomain {
    
    private let dataService = UploadVideoData()
    
<<<<<<< HEAD
    func pickVideoAndExtractMetadata() -> (url: URL, duration: String, dateTaken: String)? {
        
        guard let url = dataService.pickVideoFromFinder() else { return nil }
        
        // calculate duration
        let asset = AVAsset(url: url)
        let durationSeconds = CMTimeGetSeconds(asset.duration)
        let minutes = Int(durationSeconds) / 60
        let seconds = Int(durationSeconds) % 60
        let duration = "\(minutes)m \(seconds)s"
        
        //
        let date: String
        
        if let creationDate = asset.creationDate?.dateValue {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            date = formatter.string(from: creationDate)
            
        } else {
            date = "Unknown"
        }
        
        
        
        
        
        return (url, duration, date)
        
        
   
    }
    
=======
    func pickVideoAndExtractMetadata() async -> (url: URL, duration: String, date: String, fileSize: String)? {
        
        // run the file picker safely on the main thread
        guard let url = await MainActor.run(body: {
            dataService.pickVideoFromFinder()
        }) else {
            return nil
        }
        
        // load selected video as an AVAsset
        let asset = AVURLAsset(url: url)
        
        do {
            
            // load metadata asynchoronously
            let durationTime = try await asset.load(.duration)

            
            // format duration
            let durationSeconds = CMTimeGetSeconds(durationTime)
            let minutes = Int(durationSeconds) / 60
            let seconds = Int(durationSeconds) % 60
            let duration = "\(minutes)m \(seconds)s"
            
            
            // load creation date metadata asynchronously
            let creationDateItem = try? await asset.load(.creationDate)
            
            let creationDateValue = try? await creationDateItem?.load(.dateValue)
            
            // format creation date
            let date: String
            if let creationDate = creationDateValue {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .short
                date = formatter.string(from: creationDate)
            } else {
                date = "Unknown"
            }
            
            // compute file size
            let fileSize = formatFileSize(for: url)
            
            return (url, duration, date, fileSize)

            
        } catch {
            print("failed to load metadata: \(error.localizedDescription)")
            return nil
        }
   
    }
    
    
    // MARK: - Formats format size
    private func formatFileSize(for url: URL) -> String {
        guard let fileSizeValue = try? url.resourceValues(forKeys: [.fileSizeKey]).fileSize else {
            return "Unknown"
        }
        
        let bytes = Double(fileSizeValue)
        let megaBytes = bytes / (1024 * 1024)
        return String(format: "%.1f MB", megaBytes)
    }

    
    
>>>>>>> main
}
