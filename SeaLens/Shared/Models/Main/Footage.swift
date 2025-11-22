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
    /// Shallow mock: creates a Footage without creating related objects (no fishFamily, no footageTags)
    static func shallowMock(in context: ModelContext) -> Footage {
        let obj = Footage(
            uid: UUID(),
            filename: "video_\(UUID.randomString()).mp4",
            originalFilename: "original_\(UUID().uuidString).mp4",
            url: "file:///temp/\(UUID().uuidString).mp4",
            durationInSeconds: Int32.random(in: 30...600),
            dateTaken: Date().addingTimeInterval(-Double.random(in: 0...60*60*24*365)),
            location: ["Nusa Dua","Tulamben","Menjangan","Amed"].randomElement()!,
            siteName: "Site \(Int.random(in: 1...5))",
            transect: "Transect \(Int.random(in: 1...5))",
            depthInMeter: Double.random(in: 1...30),
            dateCreated: Date(),
            dateUpdated: Date(),
            fileSize: Double.random(in: 1_000_000...50_000_000)
        )
        context.insert(obj)
        return obj
    }

    static func shallowMock() -> Footage {
        return Footage(
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
    }
    
    /// Full mock: can optionally attach shallow related objects
    static func mock(in context: ModelContext, attachFishFamilies: Bool = false, attachTags: Bool = false) -> Footage {
        let obj = shallowMock(in: context)
        if attachFishFamilies {
            let family = FishFamily.shallowMock(in: context, footage: obj)
            obj.fishFamily.append(family)
        }
        if attachTags {
            let tag = FootageTag.shallowMock(in: context, footage: obj)
            obj.footageTags.append(tag)
        }
        return obj
    }

    static func mockArray(in context: ModelContext, count: Int = Int.random(in: 5...20)) -> [Footage] {
        (0..<count).map { _ in Footage.shallowMock(in: context) }
    }
    
    static func mockCompleteArray(
        in context: ModelContext,
        masterFamilyRefs: [FishFamilyReference] = [],
        count: Int = Int.random(in: 5...20),
        attachCompleteRef: Bool = true) -> [Footage]
    {
        if attachCompleteRef {
            return (0..<count).map { index in
                // Footage
                let obj = shallowMock(in: context)
                
                // Tags
                let tags = (0..<Int.random(in: 3...10)).map { _ in
                    FootageTag.shallowMock(in: context, footage: obj)
                }
                obj.footageTags = tags
                
                // Fish Family
                let fishFamilies = (0..<Int.random(in: 1...12)).map { _ in
                    FishFamily.shallowMock(in: context, footage: obj, masterFamilyRefs: masterFamilyRefs,  attachCompleteRef: true)
                }
                obj.fishFamily = fishFamilies
                
                return obj
            }
        } else {
            return (0..<count).map { _ in Footage.mock(in: context) }
        }
    }
}
