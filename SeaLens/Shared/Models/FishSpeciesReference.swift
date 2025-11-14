//
//  FishSpeciesReference.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftData

@Model
final class FishSpeciesReference {
    @Attribute(.unique) var uid: UUID
    var latinName: String
    var commonName: String
    var maxSizeInCm: Double
    var identification: String
    var location: String
    var imageUrl: String
    var sourceUrl: String
    var attribution: String
    
    //0..Many fishSpeciesReference belong to one fishFamilyReference
    var fishFamilyReference: FishFamilyReference?
    
    @Relationship(deleteRule: .nullify, inverse: \IndividualFish.fishSpeciesReference)
    var individualFishes: [IndividualFish]?
    
    init(
        uid: UUID,
        latinName: String,
        commonName: String,
        maxSizeInCm: Double,
        identification: String,
        location: String,
        imageUrl: String,
        sourceUrl: String,
        attribution: String,
        fishFamilyReference: FishFamilyReference,
        individualFishes: [IndividualFish] = [])
    {
        self.uid = uid
        self.latinName = latinName
        self.commonName = commonName
        self.maxSizeInCm = maxSizeInCm
        self.identification = identification
        self.location = location
        self.imageUrl = imageUrl
        self.sourceUrl = sourceUrl
        self.attribution = attribution
        
        self.fishFamilyReference = fishFamilyReference
        self.individualFishes = individualFishes
    }
}
