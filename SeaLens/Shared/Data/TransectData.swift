//
//  TransectData.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import SwiftData
import Foundation

final class TransectData {
    private let dataService: DataService
    
    var transects: [Transect] = []
    var errorMessage: String?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // Basic CRUD Operations

    // RETRIEVE TRANSECT
    func retrieveTransects() async -> Result<[Transect], any Error> {
        do {
            let sortDescriptors = [SortDescriptor(\Transect.name)]
            transects = try await dataService.retrieve(Transect.self, predicate: nil, sortBy: sortDescriptors)
            return .success(transects)
        } catch {
            errorMessage = "Failed to retrieve transects: \(error.localizedDescription)"
            return .failure(error)
        }
    }
    
    func retrieveTransects(predicate: Predicate<Transect>? = nil, sortBy: [SortDescriptor<Transect>]?) async -> Result<[Transect], any Error> {
        do {
            transects = try await dataService.retrieve(Transect.self, predicate: predicate, sortBy: sortBy!)
            return .success(transects)
        } catch {
            return .failure(error)
        }
    }
    
    // CREATE TRANSECT
    func addTransect(transect: Transect) async {
        
        await dataService.insert(transect)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to add transect: \(error.localizedDescription)"
        }
    }
    
    // UPDATE TRANSECT
    func updateTransect(_ transect: Transect) async {
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to update transect: \(error.localizedDescription)"
        }
    }
    
    // DELETE TRANSECT
    func deleteTransect(_ transect: Transect) async {
        await dataService.delete(transect)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to delete transect: \(error.localizedDescription)"
        }
    }

}
