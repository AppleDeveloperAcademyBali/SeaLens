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

// MARK: - FishFamily
extension FishFamily {
    static func shallowMock(in context: ModelContext, footage: Footage) -> FishFamily {
        let obj = FishFamily(
            uid: UUID(),
            numOfFishDetected: Int32.random(in: 1...80),
            dateCreated: Date(),
            dateUpdated: Date(),
            footage: footage,
            fishFamilyReference: nil,
            fishes: []
        )
        context.insert(obj)
        return obj
    }

    static func shallowMock() -> FishFamily {
        return FishFamily(
            numOfFishDetected: 10,
            dateCreated: .randomDaysAgo(10),
            dateUpdated: .randomDaysAgo(1),
            footage: Footage.shallowMock(),
            fishFamilyReference: FishFamilyReference.shallowMock(),
            fishes: [])
    }
    
    static func shallowMock(
        in context: ModelContext,
        footage: Footage,
        masterFamilyRefs: [FishFamilyReference] = [],
        attachCompleteRef: Bool = true) -> FishFamily
    {
        if attachCompleteRef {
            let obj = FishFamily.shallowMock(in: context, footage: footage)
            
            // FishFamilyReference
            if masterFamilyRefs.isEmpty {
                obj.fishFamilyReference = FishFamilyReference.shallowMock(in: context)
            } else {
                obj.fishFamilyReference = masterFamilyRefs.randomElement()
            }
            
            // Fish
            let fish = Fish.mockArray(in: context, fishFamily: obj)
            obj.fishes = fish
            
            return obj
        } else {
            return shallowMock(in: context, footage: footage)
        }
    }
    
    static func mock(in context: ModelContext, footage: Footage? = nil, familyRef: FishFamilyReference? = nil, attachFishes: Bool = false) -> FishFamily {
        let footage = footage ?? Footage.shallowMock(in: context)
        let obj = shallowMock(in: context, footage: footage)
        if let familyRef = familyRef {
            obj.fishFamilyReference = familyRef
        }
        if attachFishes {
            let fish = Fish.shallowMock(in: context, fishFamily: obj)
            obj.fishes.append(fish)
        }
        return obj
    }

    static func mockArray(in context: ModelContext, count: Int = Int.random(in: 2...5), footage: Footage? = nil) -> [FishFamily] {
        (0..<count).map { _ in mock(in: context, footage: footage) }
    }
}
