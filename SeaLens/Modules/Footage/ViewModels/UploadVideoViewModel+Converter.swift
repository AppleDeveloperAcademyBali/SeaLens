//
//  UploadVideoViewModel+Converter.swift
//  SeaLens
//
//  Created by Handy Handy on 08/11/25.
//

import Foundation
import AVFoundation

extension UploadVideoViewModel {
    func createFootage() -> Footage {
        let footage = Footage(
            uid: UUID(),
            filename: self.fileName,
            originalFilename: self.originalFileName,
            //TODO: What kind of url is it?
            url: self.selectedFileURL?.absoluteString ?? "",
            durationInSeconds: Int32(rawFileDuration),
            dateTaken: self.rawDateTaken,
            location: self.location,
            siteName: self.site,
            transect: self.transect,
            depthInMeter: Double(self.depth) ?? 0,
            dateCreated: Date(),
            dateUpdated: Date(),
            fileSize: self.rawFileSize
        )
        let customTags = self.tags.map { tag in
            FootageTag(uid: UUID(), name: tag, footage: footage)
        }
        footage.footageTags = customTags
        return footage
    }
    
    func parseTimeToSeconds(_ text: String) -> Int32? {
        let pattern = #"(?:(\d+)m)?\s*(?:(\d+)s)?"#
        let regex = try! NSRegularExpression(pattern: pattern)
        
        if let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)) {
            let minuteRange = Range(match.range(at: 1), in: text)
            let secondRange = Range(match.range(at: 2), in: text)
            
            let minutes = minuteRange.flatMap { Int(text[$0]) } ?? 0
            let seconds = secondRange.flatMap { Int(text[$0]) } ?? 0
            
            return Int32(minutes * 60 + seconds)
        }
        return nil
    }
    
    func parseDate(_ text: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.date(from: text)
    }
    
    func createLocationSuggestions() {
        Task(priority: .utility) { @MainActor in
            self.locationSuggestion = await domain.getLocations().map({ location in
                location.name
            })
        }
    }
    
    func createSiteSuggestions() {
        Task(priority: .utility) { @MainActor in
            self.siteSuggestion = await domain.getSites().map({ site in
                site.name
            })
        }
    }
    
    func createTransectSuggestions() {
        Task(priority: .utility) { @MainActor in
            self.transectSuggestion = await domain.getTransects().map({ transect in
                transect.name
            })
        }
    }
    
    // MARK: - Helper Functions
    // format time
    func formatDuration(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return "\(minutes)m \(seconds)s"
    }
    
    // format date
    func formatCreationDate(_ date: Date?) -> String {
        guard let date else { return "Unknown" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    // format file size
    func formatFileSize(for url: URL) -> String {
        guard let fileSizeValue = try? url.resourceValues(forKeys: [.fileSizeKey]).fileSize else {
            return "Unknown"
        }
        
        let bytes = Double(fileSizeValue)
        let megaBytes = bytes / (1024 * 1024)
        return String(format: "%.1f MB", megaBytes)
    }
    
}
