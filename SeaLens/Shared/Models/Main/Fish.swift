//
//  IndividualFish.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 14/11/25.
//

import SwiftData
import Foundation

@Model
final class Fish {
    @Attribute(.unique) var uid: UUID
    var fishId: String
    var dateCreated: Date
    var dateUpdated: Date
    
    // One Individual Fish belong to one Fish Family
    var fishFamily: FishFamily
    
    // One Individual Fish will only have one species reference
    var fishSpeciesReference: FishSpeciesReference?
    
    // One Individual Fish will have more than one Fish
    // Delete when Individual Fish get deleted
    @Relationship(deleteRule: .cascade, inverse: \FishImage.fish)
    var fishImages: [FishImage] = []
    
    init(
        uid: UUID = .init(),
        fishId: String,
        dateCreated: Date,
        dateUpdated: Date,
        fishFamily: FishFamily,
        fishSpeciesReference: FishSpeciesReference,
        fishImages: [FishImage])
    {
        self.uid = uid
        self.fishId = fishId
        self.dateCreated = dateCreated
        self.dateUpdated = dateUpdated
        self.fishFamily = fishFamily
        self.fishSpeciesReference = fishSpeciesReference
        self.fishImages = fishImages
    }
}

// MARK: - Mock Data
extension Fish {

    static let mock: Fish = Fish(
        fishId: "FISH-0001",
        dateCreated: .randomDaysAgo(20),
        dateUpdated: .randomDaysAgo(1),
        fishFamily: FishFamily.mock,
        fishSpeciesReference: FishSpeciesReference.mock,
        fishImages: []
    )

    static var mockArray: [Fish] {
        (0..<Int.random(in: 3...10)).map { _ in
            Fish(
                fishId: "FISH-\(UUID.randomString())",
                dateCreated: .randomDaysAgo(Int.random(in: 10...40)),
                dateUpdated: .randomDaysAgo(1),
                fishFamily: FishFamily.mockArray.randomElement() ?? FishFamily.mock,
                fishSpeciesReference: FishSpeciesReference.mockArray.randomElement() ?? FishSpeciesReference.mock,
                fishImages: []
            )
        }
    }
}
