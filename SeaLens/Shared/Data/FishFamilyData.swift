//
//  FishFamilyData.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import SwiftData
import Foundation

@Observable
final class FishFamilyData {
    private let dataService: DataService
    
    var fishFamilies: [FishFamily] = []
    var errorMessage: String?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // Basic CRUD Operations

    // RETRIEVE FISH FAMILY
    func retrieveFishFamilies() {
        errorMessage = nil
        
        do {
            let sortDescriptors = [SortDescriptor(\FishFamily.numOfFishDetected)]
            fishFamilies = try dataService.retrieve(FishFamily.self, predicate: nil, sortBy: sortDescriptors)
        } catch {
            errorMessage = "Failed to retrieve fish families: \(error.localizedDescription)"
        }
    }
    
    func retrieveFishFamilies(predicate: Predicate<FishFamily>? = nil, sortBy: [SortDescriptor<FishFamily>]?) {
        errorMessage = nil
        
        do {
            fishFamilies = try dataService.retrieve(FishFamily.self, predicate: predicate, sortBy: sortBy!)
        } catch {
            errorMessage = "Failed to retrieve fish families: \(error.localizedDescription)"
        }
    }
    
    // CREATE FISH FAMILY
    func addFishFamily(fishFamily: FishFamily) {
        
        dataService.insert(fishFamily)
        
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to add fish family: \(error.localizedDescription)"
        }
    }
    
    // UPDATE FISH FAMILY
    func updateFishFamily(_ fishFamily: FishFamily) {
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to update fish family: \(error.localizedDescription)"
        }
    }
    
    // DELETE FISH FAMILY
    func deleteFishFamily(_ fishFamily: FishFamily) {
        dataService.delete(fishFamily)
        
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to delete fish family: \(error.localizedDescription)"
        }
    }

}
