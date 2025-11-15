//
//  UploadVideoViewModel+Converter.swift
//  SeaLens
//
//  Created by Handy Handy on 08/11/25.
//

import Foundation

extension UploadVideoViewModel {
    func createFootage() -> Footage {
        let footage = Footage(
            uid: UUID(),
            filename: self.fileName,
            originalFilename: self.originalFileName,
            //TODO: What kind of url is it?
            footageUrl: self.selectedFileURL?.absoluteString ?? "",
            durationInSeconds: parseTimeToSeconds(self.fileDuration) ?? 0,
            dateTaken: parseDate(self.date) ?? Date(),
            location: self.location,
            siteName: self.site,
            transect: self.transect,
            depthInMeter: Double(self.depth) ?? 0,
            dateCreated: Date(),
            dateUpdated: Date()
        )
        let customTags = self.tags.map { tag in
            FootageTags(uid: UUID(), name: tag, footage: footage)
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
    
}
