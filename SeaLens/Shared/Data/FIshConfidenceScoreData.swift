//
//  FIshConfidenceScoreData.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import SwiftData
import Foundation

@Observable
final class FishConfidenceScoreData {
    private let dataService: DataService
    
    var fishConfidenceScores: [FishConfidenceScore] = []
    var errorMessage: String?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // Basic CRUD Operations

    // RETRIEVE FISH CONFIDENCE SCORE
    func retrieveFishConfidenceScores() {
        errorMessage = nil
        
        do {
            let sortDescriptors = [SortDescriptor(\FishConfidenceScore.confidenceValue, order: .reverse)]
            fishConfidenceScores = try dataService.retrieve(FishConfidenceScore.self, predicate: nil, sortBy: sortDescriptors)
        } catch {
            errorMessage = "Failed to retrieve fish confidence scores: \(error.localizedDescription)"
        }
    }
    
    func retrieveFishConfidenceScores(predicate: Predicate<FishConfidenceScore>? = nil, sortBy: [SortDescriptor<FishConfidenceScore>]?) {
        errorMessage = nil
        
        do {
            fishConfidenceScores = try dataService.retrieve(FishConfidenceScore.self, predicate: predicate, sortBy: sortBy!)
        } catch {
            errorMessage = "Failed to retrieve fish confidence scores: \(error.localizedDescription)"
        }
    }
    
    // CREATE FISH CONFIDENCE SCORE
    func addFishConfidenceScore(fishConfidenceScore: FishConfidenceScore) {
        
        dataService.insert(fishConfidenceScore)
        
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to add fish confidence score: \(error.localizedDescription)"
        }
    }
    
    // UPDATE FISH CONFIDENCE SCORE
    func updateFishConfidenceScore(_ fishConfidenceScore: FishConfidenceScore) {
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to update fish confidence score: \(error.localizedDescription)"
        }
    }
    
    // DELETE FISH CONFIDENCE SCORE
    func deleteFishConfidenceScore(_ fishConfidenceScore: FishConfidenceScore) {
        dataService.delete(fishConfidenceScore)
        
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to delete fish confidence score: \(error.localizedDescription)"
        }
    }

}
