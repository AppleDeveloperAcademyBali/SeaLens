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
        fishSpeciesReference: FishSpeciesReference?,
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
    static func shallowMock(in context: ModelContext, fishFamily: FishFamily) -> Fish {
        let obj = Fish(uid: UUID(), fishId: "FISH-\(UUID().uuidString.prefix(6))", dateCreated: Date(), dateUpdated: Date(), fishFamily: fishFamily, fishSpeciesReference: nil, fishImages: [])
        context.insert(obj)
        return obj
    }

    static func shallowMock() -> Fish {
        return Fish(
            fishId: "FISH-0001",
            dateCreated: .randomDaysAgo(20),
            dateUpdated: .randomDaysAgo(1),
            fishFamily: FishFamily.shallowMock(),
            fishSpeciesReference: FishSpeciesReference.shallowMock(),
            fishImages: []
        )
    }
    
    static func mock(in context: ModelContext, fishFamily: FishFamily? = nil, speciesRef: FishSpeciesReference? = nil, attachImages: Bool = true) -> Fish {
        let family = fishFamily ?? FishFamily.mock(in: context)
        let obj = shallowMock(in: context, fishFamily: family)
        if let speciesRef = speciesRef { obj.fishSpeciesReference = speciesRef }
        if attachImages {
            let img = FishImage.mockArray(in: context, count: 5, fish: obj)
            obj.fishImages = img
        }
        return obj
    }

    static func mockArray(in context: ModelContext, count: Int = Int.random(in: 2...6), fishFamily: FishFamily? = nil) -> [Fish] {
        (0..<count).map { _ in mock(in: context, fishFamily: fishFamily) }
    }
}

