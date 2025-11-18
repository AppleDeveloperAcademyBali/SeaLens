//
//  UploadVideoDomain+File.swift
//  SeaLens
//
//  Created by Handy Handy on 08/11/25.
//

import Foundation
import AVFoundation

extension UploadVideoDomain {
    
    // MARK: - Open Finder Function
    func pickVideoAndExtractMetadata() async -> (url: URL, duration: Double, date: Date, fileSize: Double)? {
        
        // run the file picker safely on the main thread
        guard let url = await MainActor.run(body: {
            uploadVideoData.pickVideoFromFinder()
        }) else { return nil }
        return await extractMetadata(from: url)
    }
    
    // MARK: - Extract Metadata from Video
    func extractMetadata(from url: URL) async -> (url: URL, duration: Double, date: Date, fileSize: Double)? {
        
        // load selected video as an AVAsset
        let asset = AVURLAsset(url: url)
        
        do {
            
            // load metadata asynchoronously
            let durationTime = try await asset.load(.duration)
            guard
            let creationDateItem = try? await asset.load(.creationDate),
            let creationDateValue = try? await creationDateItem.load(.dateValue)
                else { return nil }
            
            // use helper methods
//            let duration = formatDuration(durationTime)
//            let date = formatCreationDate(creationDateValue)
//            let fileSize = formatFileSize(for: url)
            
            let totalSeconds = CMTimeGetSeconds(durationTime)
            guard let fileSizeValue = try? url.resourceValues(forKeys: [.fileSizeKey]).fileSize else {
                return nil
            }
            
            return (url, totalSeconds, creationDateValue, Double(fileSizeValue))

            
        } catch {
            print("failed to load metadata: \(error.localizedDescription)")
            return nil
        }
   
    }
}
