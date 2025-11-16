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

// MARK: - Mock Data
extension FishImage {

    static let mock: FishImage = FishImage(
        imageUrl: "file:///images/fish_mock.jpg",
        objectRecognitionConf: 0.92,
        timestamp: "00:01:20",
        isFavorites: true,
        dateCreated: .randomDaysAgo(30),
        dateUpdated: .randomDaysAgo(2),
        fish: Fish.mock,
        fishConfidenceScore: []
    )

    static var mockArray: [FishImage] {
        (0..<Int.random(in: 3...10)).map { _ in
            FishImage(
                imageUrl: "file:///images/\(UUID.randomString()).jpg",
                objectRecognitionConf: Double.random(in: 0.5...0.99),
                timestamp: "00:0\(Int.random(in: 1...5)):\(Int.random(in: 10...59))",
                isFavorites: Bool.random(),
                dateCreated: .randomDaysAgo(Int.random(in: 10...60)),
                dateUpdated: .randomDaysAgo(1),
                fish: Fish.mockArray.randomElement() ?? Fish.mock,
                fishConfidenceScore: []
            )
        }
    }
}
