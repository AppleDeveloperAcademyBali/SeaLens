//
//  IndividualFishData.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 14/11/25.
//

import SwiftData
import Foundation

final class IndividualFishData {
    private let dataService: DataService
    
    var individualFishes: [IndividualFish] = []
    var errorMessage: String?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // Basic CRUD Operations

    // RETRIEVE INDIVIDUAL FISH
    func retrieveIndividualFishes() async {
        errorMessage = nil
        
        do {
            let sortDescriptors = [SortDescriptor(\IndividualFish.fishId)]
            individualFishes = try await dataService.retrieve(IndividualFish.self, predicate: nil, sortBy: sortDescriptors)
        } catch {
            errorMessage = "Failed to retrieve individual fish: \(error.localizedDescription)"
        }
    }
    
    func retrieveIndividualFishes(predicate: Predicate<IndividualFish>?, sortBy: [SortDescriptor<IndividualFish>]?) async {
        errorMessage = nil
        
        do {
            individualFishes = try await dataService.retrieve(IndividualFish.self, predicate: predicate, sortBy: sortBy!)
        } catch {
            errorMessage = "Failed to retrieve individual fish: \(error.localizedDescription)"
        }
    }
    
    // CREATE INDIVIDUAL FISH
    func addIndividualFish(individualFish: IndividualFish) async {
        
        await dataService.insert(individualFish)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to add individual fish: \(error.localizedDescription)"
        }
    }
    
    // UPDATE INDIVIDUAL FISH
    func updateIndividualFish(_ individualFish: IndividualFish) async {
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to update individual fish: \(error.localizedDescription)"
        }
    }
    
    // DELETE INDIVIDUAL FISH
    func deleteIndividualFish(_ individualFish: IndividualFish) async {
        await dataService.delete(individualFish)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to delete individual fish: \(error.localizedDescription)"
        }
    }

}
