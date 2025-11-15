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
    
    @Relationship(deleteRule: .nullify, inverse: \Fish.fishSpeciesReference)
    var fishes: [Fish]?
    
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
        fishes: [Fish] = [])
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
        self.fishes = fishes
    }
}

// MARK: - Mock Data
extension FishSpeciesReference {

    static let mock: FishSpeciesReference = FishSpeciesReference(
        uid: UUID(),
        latinName: "Chromis viridis",
        commonName: "Blue-green chromis",
        maxSizeInCm: 8,
        identification: "Small planktivorous damselfish.",
        location: "Indo-Pacific",
        imageUrl: "https://example.com/chromis.jpg",
        sourceUrl: "https://example.com/chromis-viridis",
        attribution: "Allen, 2000",
        fishFamilyReference: FishFamilyReference.mock,
        fishes: []
    )

    static var mockArray: [FishSpeciesReference] {
        (0..<Int.random(in: 3...10)).map { _ in
            FishSpeciesReference(
                uid: UUID(),
                latinName: ["Thalassoma lunare","Chromis atripectoralis","Chaetodon lunula"].randomElement()!,
                commonName: ["Wrasse","Chromis","Butterflyfish"].randomElement()!,
                maxSizeInCm: Double.random(in: 6...40),
                identification: "A reef fish commonly seen in shallow waters.",
                location: ["Nusa Dua","Menjangan","Komodo","Raja Ampat"].randomElement()!,
                imageUrl: "https://example.com/\(UUID.randomString()).jpg",
                sourceUrl: "https://example.com/species/\(UUID.randomString())",
                attribution: ["Allen (2000)","Randall (1997)"].randomElement()!,
                fishFamilyReference: FishFamilyReference.mockArray.randomElement() ?? FishFamilyReference.mock,
                fishes: []
            )
        }
    }
}
