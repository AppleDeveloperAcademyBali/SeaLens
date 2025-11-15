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
    
    @Relationship(deleteRule: .cascade, inverse: \Fish.fishFamily)
    var fishes: [Fish] = []
    
    
    init(
        uid: UUID = .init(),
        numOfFishDetected: Int32,
        dateCreated: Date,
        dateUpdated: Date,
        footage: Footage,
        fishFamilyReference: FishFamilyReference? = nil,
        fishes: [Fish] = [])
    {
        self.uid = uid
        self.numOfFishDetected = numOfFishDetected
        self.dateCreated = dateCreated
        self.dateUpdated = dateUpdated
        self.footage = footage
        self.fishFamilyReference = fishFamilyReference
        self.fishes = fishes
    }
    
}

// MARK: - Mock Data
extension FishFamily {

    static let mock: FishFamily = FishFamily(
        numOfFishDetected: 10,
        dateCreated: .randomDaysAgo(10),
        dateUpdated: .randomDaysAgo(1),
        footage: Footage.mock,
        fishFamilyReference: FishFamilyReference.mock,
        fishes: []
    )

    static var mockArray: [FishFamily] {
        (0..<Int.random(in: 3...10)).map { _ in
            FishFamily(
                numOfFishDetected: Int32.random(in: 1...80),
                dateCreated: .randomDaysAgo(Int.random(in: 5...50)),
                dateUpdated: .randomDaysAgo(1),
                footage: Footage.mockArray.randomElement() ?? Footage.mock,
                fishFamilyReference: FishFamilyReference.mockArray.randomElement() ?? FishFamilyReference.mock,
                fishes: []
            )
        }
    }
}
