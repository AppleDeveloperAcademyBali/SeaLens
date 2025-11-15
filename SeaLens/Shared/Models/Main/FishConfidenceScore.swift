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

// MARK: - Mock Data
extension FishConfidenceScore {

    static let mock: FishConfidenceScore = FishConfidenceScore(
        familyLatinName: "Pomacentridae",
        confidenceValue: 0.85,
        fish: FishImage.mock
    )

    static var mockArray: [FishConfidenceScore] {
        (0..<Int.random(in: 3...10)).map { _ in
            FishConfidenceScore(
                familyLatinName: ["Pomacentridae","Labridae","Acanthuridae"].randomElement()!,
                confidenceValue: Double.random(in: 0.1...0.99),
                fish: FishImage.mockArray.randomElement() ?? FishImage.mock
            )
        }
    }
}
