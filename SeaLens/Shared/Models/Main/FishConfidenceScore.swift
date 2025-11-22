//
//  FishConfidenceScore.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftData

@Model
final class FishConfidenceScore {
    @Attribute(.unique) var uid: UUID
    var familyLatinName: String
    var confidenceValue: Double
    
    //0..Many fishConfidenceScore belong to one Fish
    var fish: FishImage
    
    init(
        uid: UUID = .init(),
        familyLatinName: String,
        confidenceValue: Double,
        fish: FishImage)
    {
        self.uid = uid
        self.familyLatinName = familyLatinName
        self.confidenceValue = confidenceValue
        self.fish = fish
    }
}

// MARK: - FishConfidenceScore
extension FishConfidenceScore {
    static func shallowMock(in context: ModelContext, fish: FishImage) -> FishConfidenceScore {
        let obj = FishConfidenceScore(uid: UUID(), familyLatinName: ["Pomacentridae","Labridae","Acanthuridae"].randomElement()!, confidenceValue: Double.random(in: 0.1...0.99), fish: fish)
        context.insert(obj)
        return obj
    }

    static func mock(in context: ModelContext, fish: FishImage? = nil) -> FishConfidenceScore {
        let fish = fish ?? FishImage.mock(in: context)
        return shallowMock(in: context, fish: fish)
    }

    static func mockArray(in context: ModelContext, count: Int = Int.random(in: 1...5), fish: FishImage? = nil) -> [FishConfidenceScore] {
        (0..<count).map { _ in mock(in: context, fish: fish) }
    }
}


