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
    var fishSpeciesReferences: [FishSpeciesReference]?
    
    @Relationship(deleteRule:.nullify, inverse: \FishFamily.fishFamilyReference)
    var fishFamilies: [FishFamily]?
    
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

// MARK: - Mock Data
extension FishFamilyReference {

    static let mock: FishFamilyReference = FishFamilyReference(
        latinName: "Pomacentridae",
        commonName: "Damselfishes",
        imageUrl: "https://example.com/families/pomacentridae.jpg",
        sourceUrl: "https://example.com/reference/reef-fish",
        attribution: "Allen, 2000",
        fishSpeciesReferences: [],
        fishFamilies: []
    )

    static var mockArray: [FishFamilyReference] {
        (0..<Int.random(in: 3...10)).map { _ in
            FishFamilyReference(
                latinName: ["Pomacentridae","Labridae","Chaetodontidae","Acanthuridae"].randomElement()!,
                commonName: ["Damselfish","Wrasse","Butterflyfish","Surgeonfish"].randomElement()!,
                imageUrl: "https://example.com/\(UUID.randomString()).jpg",
                sourceUrl: "https://example.com/book/\(UUID.randomString())",
                attribution: ["Allen (2000)", "Randall (1997)", "Myers (1999)"].randomElement()!,
                fishSpeciesReferences: [],
                fishFamilies: []
            )
        }
    }
}
