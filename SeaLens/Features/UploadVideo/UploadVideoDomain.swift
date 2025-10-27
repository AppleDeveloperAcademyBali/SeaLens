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
    
}
