//
//  FIshConfidenceScoreData.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import SwiftData
import Foundation

final class FishConfidenceScoreData {
    private let dataService: DataService
    
    var fishConfidenceScores: [FishConfidenceScore] = []
    var errorMessage: String?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // Basic CRUD Operations

    // RETRIEVE FISH CONFIDENCE SCORE
    func retrieveFishConfidenceScores() async {
        errorMessage = nil
        
        do {
            let sortDescriptors = [SortDescriptor(\FishConfidenceScore.confidenceValue, order: .reverse)]
            fishConfidenceScores = try await dataService.retrieve(FishConfidenceScore.self, predicate: nil, sortBy: sortDescriptors)
        } catch {
            errorMessage = "Failed to retrieve fish confidence scores: \(error.localizedDescription)"
        }
    }
    
    func retrieveFishConfidenceScores(predicate: Predicate<FishConfidenceScore>? = nil, sortBy: [SortDescriptor<FishConfidenceScore>]?) async {
        errorMessage = nil
        
        do {
            fishConfidenceScores = try await dataService.retrieve(FishConfidenceScore.self, predicate: predicate, sortBy: sortBy!)
        } catch {
            errorMessage = "Failed to retrieve fish confidence scores: \(error.localizedDescription)"
        }
    }
    
    // CREATE FISH CONFIDENCE SCORE
    func addFishConfidenceScore(fishConfidenceScore: FishConfidenceScore) async {
        
        await dataService.insert(fishConfidenceScore)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to add fish confidence score: \(error.localizedDescription)"
        }
    }
    
    // UPDATE FISH CONFIDENCE SCORE
    func updateFishConfidenceScore(_ fishConfidenceScore: FishConfidenceScore) async {
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to update fish confidence score: \(error.localizedDescription)"
        }
    }
    
    // DELETE FISH CONFIDENCE SCORE
    func deleteFishConfidenceScore(_ fishConfidenceScore: FishConfidenceScore) async {
        await dataService.delete(fishConfidenceScore)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to delete fish confidence score: \(error.localizedDescription)"
        }
    }

}
