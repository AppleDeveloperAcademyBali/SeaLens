//
//  FIsh.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftData

@Model
final class Fish {
    @Attribute(.unique) var uid: UUID
    var imageUrl: String
    var objectRecognitionConf: Double
    var timestamp: String
    var isFavorites: Bool
    var dateCreated: Date
    var dateUpdated: Date
    
    //0..Many fish belong to one fishFamily
    var fishFamily: FishFamily?
    
    //0..Many fish belong to one fishSpeciesReference
    var fishSpeciesReference: FishSpeciesReference?
    
    @Relationship(deleteRule: .cascade, inverse: \FishConfidenceScore.fish)
    var fishConfidenceScores: [FishConfidenceScore] = []
    
    
    init(
        uid: UUID = .init(),
        imageUrl: String,
        objectRecognitionConf: Double,
        timestamp: String,
        isFavorites: Bool,
        dateCreated: Date,
        dateUpdated: Date,
        fishFamily: FishFamily? = nil,
        fishSpeciesReference: FishSpeciesReference? = nil,
        fishConfidenceScore: [FishConfidenceScore] = [])
    {
        self.uid = uid
        self.imageUrl = imageUrl
        self.objectRecognitionConf = objectRecognitionConf
        self.timestamp = timestamp
        self.isFavorites = isFavorites
        self.dateCreated = dateCreated
        self.dateUpdated = dateUpdated
        self.fishFamily = fishFamily
        self.fishSpeciesReference = fishSpeciesReference
        self.fishConfidenceScores = fishConfidenceScore
    }
    
}
