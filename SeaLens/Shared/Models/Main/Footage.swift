//
//  Footage.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftData

@Model
final class Footage: Equatable {
    @Attribute(.unique) var uid: UUID
    var filename: String
    var originalFilename: String
    var url: String
    var durationInSeconds: Int32
    var dateTaken: Date
    var locationName: String
    var siteName: String
    var transect: String
    var depthInMeter: Double
    var fileSize: Double // in bytes
    var dateCreated: Date
    var dateUpdated: Date
    
    @Relationship(deleteRule: .cascade, inverse: \FishFamily.footage)
    var fishFamily: [FishFamily] = []
    
    @Relationship(deleteRule: .cascade, inverse: \FootageTag.footage)
    var footageTags: [FootageTag] = []
    
    
    init(
        uid: UUID,
        filename: String,
        originalFilename: String,
        url: String,
        durationInSeconds: Int32,
        dateTaken: Date,
        location: String,
        siteName: String,
        transect: String,
        depthInMeter: Double,
        dateCreated: Date,
        dateUpdated: Date,
        fileSize: Double,
        fishFamily: [FishFamily] = [],
        footageTags: [FootageTag] = [])
    {
        self.uid = uid
        self.filename = filename
        self.originalFilename = originalFilename
        self.url = url
        self.durationInSeconds = durationInSeconds
        self.dateTaken = dateTaken
        self.locationName = location
        self.siteName = siteName
        self.transect = transect
        self.depthInMeter = depthInMeter
        self.dateCreated = dateCreated
        self.dateUpdated = dateUpdated
        self.fileSize = fileSize
        
        self.fishFamily = fishFamily
        self.footageTags = footageTags
    }
}

// MARK: - Mock Data
extension Footage {

    static let mock: Footage = Footage(
        uid: UUID(),
        filename: "DJI120_esc50_20251106.mp4",
        originalFilename: "DJI120_ORIGINAL.MP4",
        url: "file:///Documents/Footage/DJI120.mp4",
        durationInSeconds: 120,
        dateTaken: .randomDaysAgo(50),
        location: "Nusa Dua",
        siteName: "Reef Site 1",
        transect: "Transect 1",
        depthInMeter: 8,
        dateCreated: .randomDaysAgo(40),
        dateUpdated: .randomDaysAgo(1),
        fileSize: .random(in: 1000000...50000000),
        fishFamily: [],
        footageTags: []
    )

    static var mockArray: [Footage] {
        (0..<Int.random(in: 3...10)).map { i in
            Footage(
                uid: UUID(),
                filename: "video_\(i)_\(UUID.randomString()).mp4",
                originalFilename: "original_\(i).mp4",
                url: "file:///temp/\(UUID.randomString()).mp4",
                durationInSeconds: Int32.random(in: 30...600),
                dateTaken: .randomDaysAgo(Int.random(in: 1...300)),
                location: ["Nusa Dua","Tulamben","Menjangan"].randomElement()!,
                siteName: "Site \(Int.random(in: 1...5))",
                transect: "Transect \(Int.random(in: 1...5))",
                depthInMeter: Double.random(in: 3...30),
                dateCreated: .randomDaysAgo(Int.random(in: 10...250)),
                dateUpdated: .randomDaysAgo(Int.random(in: 1...5)),
                fileSize: .random(in: 1000000...50000000),
                fishFamily: [],
                footageTags: []
            )
        }
    }
}
