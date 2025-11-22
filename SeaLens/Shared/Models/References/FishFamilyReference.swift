//
//  FishFamilyReference.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class FishFamilyReference {
    @Attribute(.unique) var uid: UUID
    var latinName: String
    var commonName: String
    var imageUrl: String
    var sourceUrl: String
    var attribution: String
    
    @Relationship(deleteRule: .cascade, inverse: \FishSpeciesReference.fishFamilyReference)
    var fishSpeciesReferences: [FishSpeciesReference]?
    
    @Relationship(deleteRule:.nullify, inverse: \FishFamily.fishFamilyReference)
    var fishFamilies: [FishFamily]?
    
    // Temporary attribute
    @Transient var isSelected: Bool = false
    @Transient var totalFishCount: Int = 0
    @Transient var color: Color = .blue
    
    init(
        uid: UUID = .init(),
        latinName: String,
        commonName: String,
        imageUrl: String,
        sourceUrl: String,
        attribution: String,
        fishSpeciesReferences: [FishSpeciesReference] = [],
        fishFamilies: [FishFamily] = [])
    {
        self.uid = uid
        self.latinName = latinName
        self.commonName = commonName
        self.imageUrl = imageUrl
        self.sourceUrl = sourceUrl
        self.attribution = attribution
        
        self.fishSpeciesReferences = fishSpeciesReferences
        self.fishFamilies = fishFamilies
    }
}

// MARK: - FishFamilyReference
extension FishFamilyReference {
    static func shallowMock(in context: ModelContext) -> FishFamilyReference {
        let latin = ["Pomacanthidae","Ephippidae","Chaetodontidae","Pomacentridae","Mullidae","Serranidae","Scaridae","Siganidae","Lutjanidae","Acanthuridae","Haemulidae","Labridae"].randomElement()!
        let common = ["Angelfish", "Batfish", "Butterflyfish", "Damselfish", "Goatfish", "Grouper", "Parrotfish", "Rabbitfish", "Snapper", "Surgeonfish", "Sweetlips", "Wrasse"].randomElement()!
        let obj = FishFamilyReference(uid: UUID(), latinName: latin, commonName: common, imageUrl: "https://placehold.co/100x100?text=\(latin)", sourceUrl: "https://example.com/ref/\(UUID().uuidString)", attribution: "Author")
        context.insert(obj)
        return obj
    }
    
    static func shallowMock(in context: ModelContext, no: Int) -> FishFamilyReference {
        let latin = ["Pomacanthidae","Ephippidae","Chaetodontidae","Pomacentridae","Mullidae","Serranidae","Scaridae","Siganidae","Lutjanidae","Acanthuridae","Haemulidae","Labridae"][no]
        let common = ["Angelfish", "Batfish", "Butterflyfish", "Damselfish", "Goatfish", "Grouper", "Parrotfish", "Rabbitfish", "Snapper", "Surgeonfish", "Sweetlips", "Wrasse"][no]
        let obj = FishFamilyReference(uid: UUID(), latinName: latin, commonName: common, imageUrl: "https://placehold.co/100x100?text=\(latin)", sourceUrl: "https://example.com/ref/\(UUID().uuidString)", attribution: "Author")
        context.insert(obj)
        return obj
    }

    static func shallowMock() -> FishFamilyReference {
        return FishFamilyReference(
            latinName: "Pomacentridae",
            commonName: "Damselfishes",
            imageUrl: "https://example.com/families/pomacentridae.jpg",
            sourceUrl: "https://example.com/reference/reef-fish",
            attribution: "Allen, 2000",
            fishSpeciesReferences: [],
            fishFamilies: []
        )
    }
    
    static func mock(in context: ModelContext, attachSpeciesRefs: Bool = false) -> FishFamilyReference {
        let obj = shallowMock(in: context)
        if attachSpeciesRefs {
            let species = FishSpeciesReference.mock(in: context, familyRef: obj)
            obj.fishSpeciesReferences = [species]
        }
        return obj
    }

    static func mockArray(in context: ModelContext, count: Int = 12) -> [FishFamilyReference] {
        (0..<count).map { index in shallowMock(in: context, no: index) }
    }
}



