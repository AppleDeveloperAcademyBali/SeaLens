//
//  FishData.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 06/11/25.
//

import SwiftData
import Foundation

@Observable
final class FishData {
    private let dataService: DataService
    
    var fishes: [Fish] = []
    var errorMessage: String?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // Basic CRUD Operations

    // RETRIEVE FISH
    func retrieveFishes() {
        errorMessage = nil
        
        do {
            let sortDescriptors = [SortDescriptor(\Fish.imageUrl , order: .reverse)]
            fishes = try dataService.retrieve(Fish.self, predicate: nil, sortBy: sortDescriptors)
        } catch {
            errorMessage = "Failed to retrieve fish: \(error.localizedDescription)"
        }
    }
    
    func retrieveFishes(predicate: Predicate<Fish>?, sortBy: [SortDescriptor<Fish>]?) {
        errorMessage = nil
        
        do {
            fishes = try dataService.retrieve(Fish.self, predicate: predicate, sortBy: sortBy!)
        } catch {
            errorMessage = "Failed to retrieve fish: \(error.localizedDescription)"
        }
    }
    
    // CREATE FISH
    func addFish(fish: Fish) {
        
        dataService.insert(fish)
        
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to add fish: \(error.localizedDescription)"
        }
    }
    
    // UPDATE FISH
    func updateFish(_ fish: Fish) {
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to update fish: \(error.localizedDescription)"
        }
    }
    
    // DELETE FISH
    func deleteFish(_ fish: Fish) {
        dataService.delete(fish)
        
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to delete fish: \(error.localizedDescription)"
        }
    }

}
