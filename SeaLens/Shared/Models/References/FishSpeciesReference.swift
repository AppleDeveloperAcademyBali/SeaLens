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

// MARK: - FishSpeciesReference
extension FishSpeciesReference {
    static func shallowMock(in context: ModelContext, familyRef: FishFamilyReference? = nil) -> FishSpeciesReference {
        let familyRef = familyRef ?? FishFamilyReference.shallowMock(in: context)
        let latin = ["Thalassoma lunare","Chromis atripectoralis","Chaetodon lunula"].randomElement()!
        let common = ["Wrasse","Chromis","Butterflyfish"].randomElement()!
        let obj = FishSpeciesReference(uid: UUID(), latinName: latin, commonName: common, maxSizeInCm: Double.random(in: 6...40), identification: "A reef fish.", location: ["Nusa Dua","Menjangan","Komodo","Raja Ampat"].randomElement()!, imageUrl: "https://example.com/\(UUID().uuidString).jpg", sourceUrl: "https://example.com/species/\(UUID().uuidString)", attribution: "Author", fishFamilyReference: familyRef)
        context.insert(obj)
        return obj
    }

    static func shallowMock() -> FishSpeciesReference {
        return FishSpeciesReference(
            uid: UUID(),
            latinName: "Chromis viridis",
            commonName: "Blue-green chromis",
            maxSizeInCm: 8,
            identification: "Small planktivorous damselfish.",
            location: "Indo-Pacific",
            imageUrl: "https://example.com/chromis.jpg",
            sourceUrl: "https://example.com/chromis-viridis",
            attribution: "Allen, 2000",
            fishFamilyReference: FishFamilyReference.shallowMock(),
            fishes: [])
    }
    
    static func mock(in context: ModelContext, familyRef: FishFamilyReference? = nil, attachFishes: Bool = false) -> FishSpeciesReference {
        let obj = shallowMock(in: context, familyRef: familyRef)
        if attachFishes {
            let fish = Fish.mock(in: context, fishFamily: FishFamily.mock(in: context), speciesRef: obj)
            obj.fishes = [fish]
        }
        return obj
    }

    static func mockArray(in context: ModelContext, count: Int = Int.random(in: 3...8), familyRef: FishFamilyReference? = nil) -> [FishSpeciesReference] {
        (0..<count).map { _ in shallowMock(in: context, familyRef: familyRef) }
    }
}
