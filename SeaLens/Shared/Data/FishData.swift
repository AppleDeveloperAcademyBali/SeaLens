//
//  FishData.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 06/11/25.
//

import SwiftData
import Foundation

final class FishData {
    private let dataService: DataService
    
    var fishes: [FishImage] = []
    var errorMessage: String?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // Basic CRUD Operations

    // RETRIEVE FISH
    func retrieveFishes() async {
        errorMessage = nil
        
        do {
            let sortDescriptors = [SortDescriptor(\FishImage.url , order: .reverse)]
            fishes = try await dataService.retrieve(FishImage.self, predicate: nil, sortBy: sortDescriptors)
        } catch {
            errorMessage = "Failed to retrieve fish: \(error.localizedDescription)"
        }
    }
    
    func retrieveFishes(predicate: Predicate<FishImage>?, sortBy: [SortDescriptor<FishImage>]?) async {
        errorMessage = nil
        
        do {
            fishes = try await dataService.retrieve(FishImage.self, predicate: predicate, sortBy: sortBy!)
        } catch {
            errorMessage = "Failed to retrieve fish: \(error.localizedDescription)"
        }
    }
    
    // CREATE FISH
    func addFish(fish: FishImage) async {
        
        await dataService.insert(fish)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to add fish: \(error.localizedDescription)"
        }
    }
    
    // UPDATE FISH
    func updateFish(_ fish: FishImage) async {
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to update fish: \(error.localizedDescription)"
        }
    }
    
    // DELETE FISH
    func deleteFish(_ fish: FishImage) async {
        await dataService.delete(fish)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to delete fish: \(error.localizedDescription)"
        }
    }

}
