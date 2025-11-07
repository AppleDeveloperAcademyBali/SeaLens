//
//  Footage.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import SwiftData
import Foundation

@Observable
final class FootageData {
    private let dataService: DataService
    
    var footages: [Footage] = []
    var errorMessage: String?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // Basic CRUD Operations

    // RETRIEVE FOOTAGE
    func retrieveFootages() {
        errorMessage = nil
        
        do {
            let sortDescriptors = [SortDescriptor(\Footage.dateTaken, order: .reverse)]
            footages = try dataService.retrieve(Footage.self, predicate: nil, sortBy: sortDescriptors)
        } catch {
            errorMessage = "Failed to retrieve footages: \(error.localizedDescription)"
        }
    }
    
    func retrieveFootages(predicate: Predicate<Footage>? = nil, sortBy: [SortDescriptor<Footage>]?) {
        errorMessage = nil
        
        do {
            footages = try dataService.retrieve(Footage.self, predicate: predicate, sortBy: sortBy!)
        } catch {
            errorMessage = "Failed to retrieve footages: \(error.localizedDescription)"
        }
    }
    
    // CREATE FOOTAGE
    func addSite(footage: Footage) {
        
        dataService.insert(footage)
        
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to add footage: \(error.localizedDescription)"
        }
    }
    
    // UPDATE FOOTAGE
    func updateFootage(_ footage: Footage) {
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to update footage: \(error.localizedDescription)"
        }
    }
    
    // DELETE FOOTAGE
    func deleteFootage(_ footage: Footage) {
        dataService.delete(footage)
        
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to delete footage: \(error.localizedDescription)"
        }
    }

}
