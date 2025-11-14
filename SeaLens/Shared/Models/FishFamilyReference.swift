//
//  FishFamilyReference.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftData

@Model
final class FishFamilyReference {
    @Attribute(.unique) var uid: UUID
    var latinName: String
    var commonName: String
    var imageUrl: String
    var sourceUrl: String
    var attribution: String
    
    @Relationship(deleteRule: .cascade, inverse: \FishSpeciesReference.fishFamilyReference)
    var fishSpeciesReferences: [FishSpeciesReference] = []
    
    @Relationship(inverse: \FishFamily.fishFamilyReference)
    var fishFamilies: [FishFamily] = []
    
    init(
        uid: UUID = .init(),
        latinName: String,
        commonName: String,
        imageUrl: String,
        sourceUrl: String,
        attribution: String,
        fishSpeciesReferences: [FishSpeciesReference] = [])
    {
        self.uid = uid
        self.latinName = latinName
        self.commonName = commonName
        self.imageUrl = imageUrl
        self.sourceUrl = sourceUrl
        self.attribution = attribution
        
        self.fishSpeciesReferences = fishSpeciesReferences
    }
}
