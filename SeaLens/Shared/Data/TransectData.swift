//
//  TransectData.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import SwiftData
import Foundation

@Observable
final class TransectData {
    private let dataService: DataService
    
    var transects: [Transect] = []
    var errorMessage: String?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // Basic CRUD Operations

    // RETRIEVE TRANSECT
    func retrieveTransects() {
        errorMessage = nil
        
        do {
            let sortDescriptors = [SortDescriptor(\Transect.name)]
            transects = try dataService.retrieve(Transect.self, predicate: nil, sortBy: sortDescriptors)
        } catch {
            errorMessage = "Failed to retrieve transects: \(error.localizedDescription)"
        }
    }
    
    func retrieveTransects(predicate: Predicate<Transect>? = nil, sortBy: [SortDescriptor<Transect>]?) {
        errorMessage = nil
        
        do {
            transects = try dataService.retrieve(Transect.self, predicate: predicate, sortBy: sortBy!)
        } catch {
            errorMessage = "Failed to retrieve transects: \(error.localizedDescription)"
        }
    }
    
    // CREATE TRANSECT
    func addTransect(transect: Transect) {
        
        dataService.insert(transect)
        
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to add transect: \(error.localizedDescription)"
        }
    }
    
    // UPDATE TRANSECT
    func updateTransect(_ transect: Transect) {
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to update transect: \(error.localizedDescription)"
        }
    }
    
    // DELETE TRANSECT
    func deleteTransect(_ transect: Transect) {
        dataService.delete(transect)
        
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to delete transect: \(error.localizedDescription)"
        }
    }

}
