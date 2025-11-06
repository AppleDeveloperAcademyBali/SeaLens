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
    
    
    // MARK: - Open Finder Function
    func pickVideoAndExtractMetadata() async -> (url: URL, duration: String, date: String, fileSize: String)? {
        
        // run the file picker safely on the main thread
        guard let url = await MainActor.run(body: {
            dataService.pickVideoFromFinder()
        }) else { return nil }
        return await extractMetadata(from: url)
    }
    
    // MARK: - Extract Metadata from Video
    func extractMetadata(from url: URL) async -> (url: URL, duration: String, date: String, fileSize: String)? {
        
        // load selected video as an AVAsset
        let asset = AVURLAsset(url: url)
        
        do {
            
            // load metadata asynchoronously
            let durationTime = try await asset.load(.duration)
            let creationDateItem = try? await asset.load(.creationDate)
            let creationDateValue = try? await creationDateItem?.load(.dateValue)
            
            // use helper methods
            let duration = formatDuration(durationTime)
            let date = formatCreationDate(creationDateValue)
            let fileSize = formatFileSize(for: url)
            
            return (url, duration, date, fileSize)

            
        } catch {
            print("failed to load metadata: \(error.localizedDescription)")
            return nil
        }
   
    }
    
    // MARK: - Helper Functions
    // format time
    private func formatDuration(_ time: CMTime) -> String {
        let Totalseconds = CMTimeGetSeconds(time)
        let minutes = Int(Totalseconds) / 60
        let seconds = Int(Totalseconds) % 60
        return "\(minutes)m \(seconds)s"
    }
    
    // format date
    private func formatCreationDate(_ date: Date?) -> String {
        guard let date else { return "Unknown" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    // format file size
    private func formatFileSize(for url: URL) -> String {
        guard let fileSizeValue = try? url.resourceValues(forKeys: [.fileSizeKey]).fileSize else {
            return "Unknown"
        }
        
        let bytes = Double(fileSizeValue)
        let megaBytes = bytes / (1024 * 1024)
        return String(format: "%.1f MB", megaBytes)
    }
    
    
    
    // MARK: - Upload Video
    func uploadVideo(fileURL: URL,
                     progress: @escaping (Double) -> Void,
                     completion: @escaping (Result<String, Error>) -> Void) {
        dataService.upload(fileURL: fileURL, progress: progress, completion: completion)
        
    }

    
    
}
