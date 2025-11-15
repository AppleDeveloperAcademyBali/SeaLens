//
//  IndividualFish.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 14/11/25.
//

import SwiftData
import Foundation

@Model
final class IndividualFish {
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
    @Relationship(deleteRule: .cascade, inverse: \Fish.individualFish)
    var fish: [Fish] = []
    
    init(
        uid: UUID = .init(),
        fishId: String,
        dateCreated: Date,
        dateUpdated: Date,
        fishFamily: FishFamily,
        fishSpeciesReference: FishSpeciesReference,
        fish: [Fish])
    {
        self.uid = uid
        self.fishId = fishId
        self.dateCreated = dateCreated
        self.dateUpdated = dateUpdated
        self.fishFamily = fishFamily
        self.fishSpeciesReference = fishSpeciesReference
        self.fish = fish
    }
}
