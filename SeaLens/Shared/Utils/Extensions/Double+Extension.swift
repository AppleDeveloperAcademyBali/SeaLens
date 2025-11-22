//
//  Double+Extension.swift
//  SeaLens
//
//  Created by Handy Handy on 20/11/25.
//

import Foundation

extension Double {
    func formatDuration() -> String {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return "\(minutes)m \(seconds)s"
    }
    
    // format file size
    func formatFileSize() -> String {
        let megaBytes = self / (1024 * 1024)
        return String(format: "%.1f MB", megaBytes)
    }
}

