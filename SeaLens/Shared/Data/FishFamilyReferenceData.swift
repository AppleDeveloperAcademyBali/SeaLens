//
//  FishFamilyReferenceData.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import SwiftData
import Foundation

final class FishFamilyReferenceData {
    private let dataService: DataService
    
    var fishFamilyReferences: [FishFamilyReference] = []
    var errorMessage: String?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // Basic CRUD Operations

    // RETRIEVE FISH FAMILY REFERENCE
    func retrieveFishFamilyReferences() async {
        errorMessage = nil
        
        do {
            let sortDescriptors = [SortDescriptor(\FishFamilyReference.latinName)]
            fishFamilyReferences = try await dataService.retrieve(FishFamilyReference.self, predicate: nil, sortBy: sortDescriptors)
        } catch {
            errorMessage = "Failed to retrieve fish family references: \(error.localizedDescription)"
        }
    }
    
    func retrieveFishFamilyReferences(predicate: Predicate<FishFamilyReference>? = nil, sortBy: [SortDescriptor<FishFamilyReference>]?) async {
        errorMessage = nil
        
        do {
            fishFamilyReferences = try await dataService.retrieve(FishFamilyReference.self, predicate: predicate, sortBy: sortBy!)
        } catch {
            errorMessage = "Failed to retrieve fish family references: \(error.localizedDescription)"
        }
    }
    
    // CREATE FISH FAMILY REFERENCE
    func addFishFamilyReference(fishFamilyReference: FishFamilyReference) async {
        
        await dataService.insert(fishFamilyReference)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to add fish family references: \(error.localizedDescription)"
        }
    }
    
    // UPDATE FISH FAMILY REFERENCE
    func updateFishFamilyReference(_ fishFamilyReference: FishFamilyReference) async {
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to update fish family references: \(error.localizedDescription)"
        }
    }
    
    // DELETE FISH FAMILY REFERENCE
    func deleteFishFamilyReference(_ fishFamilyReference: FishFamilyReference) async {
        await dataService.delete(fishFamilyReference)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to delete fish family references: \(error.localizedDescription)"
        }
    }

}
