//
//  FishSpeciesReferenceData.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import SwiftData
import Foundation

@Observable
final class FishSpeciesReferenceData {
    private let dataService: DataService
    
    var fishSpeciesReferences: [FishSpeciesReference] = []
    var errorMessage: String?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // Basic CRUD Operations

    // RETRIEVE FISH SPECIES REFERENCE
    func retrieveFishSpeciesReferences() {
        errorMessage = nil
        
        do {
            let sortDescriptors = [SortDescriptor(\FishSpeciesReference.latinName)]
            fishSpeciesReferences = try dataService.retrieve(FishSpeciesReference.self, predicate: nil, sortBy: sortDescriptors)
        } catch {
            errorMessage = "Failed to retrieve fish species references: \(error.localizedDescription)"
        }
    }
    
    func retrieveFishSpeciesReferences(predicate: Predicate<FishSpeciesReference>? = nil, sortBy: [SortDescriptor<FishSpeciesReference>]?) {
        errorMessage = nil
        
        do {
            fishSpeciesReferences = try dataService.retrieve(FishSpeciesReference.self, predicate: predicate, sortBy: sortBy!)
        } catch {
            errorMessage = "Failed to retrieve fish species references: \(error.localizedDescription)"
        }
    }
    
    // CREATE FISH SPECIES REFERENCE
    func addFishSpeciesReference(fishSpeciesReference: FishSpeciesReference) {
        
        dataService.insert(fishSpeciesReference)
        
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to add fish species reference: \(error.localizedDescription)"
        }
    }
    
    // UPDATE FISH SPECIES REFERENCE
    func updateFishSpeciesReference(_ fishSpeciesReference: FishSpeciesReference) {
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to update fish species reference: \(error.localizedDescription)"
        }
    }
    
    // DELETE FISH SPECIES REFERENCE
    func deleteFishSpeciesReference(_ fishSpeciesReference: FishSpeciesReference) {
        dataService.delete(fishSpeciesReference)
        
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to delete fish species reference: \(error.localizedDescription)"
        }
    }

}
