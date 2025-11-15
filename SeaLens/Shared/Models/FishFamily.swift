//
//  FishFamily.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftData

@Model
final class FishFamily {
    @Attribute(.unique) var uid: UUID
    var numOfFishDetected: Int32
    var dateCreated: Date
    var dateUpdated: Date
    
    //0..Many fishFamily belong to one footage
    var footage: Footage
    
    //0..Many fishFamily belong to 0..one FishFamilyReference
    var fishFamilyReference: FishFamilyReference?
    
    @Relationship(deleteRule: .cascade, inverse: \IndividualFish.fishFamily)
    var individualFishes: [IndividualFish] = []
    
    
    init(
        uid: UUID = .init(),
        numOfFishDetected: Int32,
        dateCreated: Date,
        dateUpdated: Date,
        footage: Footage,
        fishFamilyReference: FishFamilyReference? = nil,
        individualFishes: [IndividualFish] = [])
    {
        self.uid = uid
        self.numOfFishDetected = numOfFishDetected
        self.dateCreated = dateCreated
        self.dateUpdated = dateUpdated
        self.footage = footage
        self.fishFamilyReference = fishFamilyReference
        self.individualFishes = individualFishes
    }
    
}
