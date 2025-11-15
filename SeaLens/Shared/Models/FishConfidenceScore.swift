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
    var fish: Fish
    
    
    init(
        uid: UUID = .init(),
        familyLatinName: String,
        confidenceValue: Double,
        fish: Fish)
    {
        self.uid = uid
        self.familyLatinName = familyLatinName
        self.confidenceValue = confidenceValue
        self.fish = fish
    }
}
