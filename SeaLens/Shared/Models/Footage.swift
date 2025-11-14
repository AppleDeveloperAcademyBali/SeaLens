//
//  Footage.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftData

@Model
final class Footage {
    @Attribute(.unique) var uid: UUID
    var filename: String
    var originalFilename: String
    var footageUrl: String
    var durationInSeconds: Int32
    var dateTaken: Date
    var locationName: String
    var siteName: String
    var transect: String
    var depthInMeter: Double
    var dateCreated: Date
    var dateUpdated: Date
    
    @Relationship(deleteRule: .cascade, inverse: \FishFamily.footage)
    var fishFamily: [FishFamily] = []
    
    @Relationship(deleteRule: .cascade, inverse: \FootageTags.footage)
    var footageTags: [FootageTags] = []
    
    
    init(
        uid: UUID,
        filename: String,
        originalFilename: String,
        footageUrl: String,
        durationInSeconds: Int32,
        dateTaken: Date,
        location: String,
        siteName: String,
        transect: String,
        depthInMeter: Double,
        dateCreated: Date,
        dateUpdated: Date,
        footageTags: [FootageTags])
    {
        self.uid = uid
        self.filename = filename
        self.originalFilename = originalFilename
        self.footageUrl = footageUrl
        self.durationInSeconds = durationInSeconds
        self.dateTaken = dateTaken
        self.locationName = location
        self.siteName = siteName
        self.transect = transect
        self.depthInMeter = depthInMeter
        self.dateCreated = dateCreated
        self.dateUpdated = dateUpdated
        self.footageTags = footageTags
    }
}
