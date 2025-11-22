//
//  FIsh.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftData

@Model
final class FishImage {
    @Attribute(.unique) var uid: UUID
    var url: String
    var objectRecognitionConf: Double
    var timestamp: String
    var isFavorites: Bool
    var dateCreated: Date
    var dateUpdated: Date
    
    //0..Many fish belong to one Fish
    var fish: Fish
    
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
        fish: Fish,
        fishConfidenceScore: [FishConfidenceScore] = [])
    {
        self.uid = uid
        self.url = imageUrl
        self.objectRecognitionConf = objectRecognitionConf
        self.timestamp = timestamp
        self.isFavorites = isFavorites
        self.dateCreated = dateCreated
        self.dateUpdated = dateUpdated
        
        self.fish = fish
        self.fishConfidenceScores = fishConfidenceScore
    }
    
}

// MARK: - FishImage
extension FishImage {
    static func shallowMock(in context: ModelContext, fish: Fish) -> FishImage {
        let obj = FishImage(uid: UUID(), imageUrl: "file:///images/\(UUID().uuidString).jpg", objectRecognitionConf: Double.random(in: 0.5...0.99), timestamp: "00:00:\(Int.random(in: 10...59))", isFavorites: Bool.random(), dateCreated: Date(), dateUpdated: Date(), fish: fish, fishConfidenceScore: [])
        context.insert(obj)
        return obj
    }

    static func mock(in context: ModelContext, fish: Fish? = nil, attachScores: Bool = true) -> FishImage {
        let fish = fish ?? Fish.mock(in: context)
        let obj = shallowMock(in: context, fish: fish)
        if attachScores {
            let score = FishConfidenceScore.shallowMock(in: context, fish: obj)
            obj.fishConfidenceScores.append(score)
        }
        return obj
    }

    static func mockArray(in context: ModelContext, count: Int = Int.random(in: 1...4), fish: Fish? = nil) -> [FishImage] {
        (0..<count).map { _ in mock(in: context, fish: fish) }
    }
}
