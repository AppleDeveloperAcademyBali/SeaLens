//
//  Location.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import SwiftData
import Foundation

@Observable
final class LocationData {
    private let dataService: DataService
    
    var locations: [Location] = []
    var errorMessage: String?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // Basic CRUD Operations

    // RETRIEVE LOCATION
    func retrieveLocations() {
        errorMessage = nil
        
        do {
            let sortDescriptors = [SortDescriptor(\Location.name)]
            locations = try dataService.retrieve(Location.self, predicate: nil, sortBy: sortDescriptors)
        } catch {
            errorMessage = "Failed to retrieve locations: \(error.localizedDescription)"
        }
    }
    
    func retrieveLocations(predicate: Predicate<Location>? = nil, sortBy: [SortDescriptor<Location>]?) {
        errorMessage = nil
        
        do {
            locations = try dataService.retrieve(Location.self, predicate: predicate, sortBy: sortBy!)
        } catch {
            errorMessage = "Failed to retrieve locations: \(error.localizedDescription)"
        }
    }
    
    // CREATE LOCATION
    func addLocation(location: Location) {
        
        dataService.insert(location)
        
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to add location: \(error.localizedDescription)"
        }
    }
    
    // UPDATE LOCATION
    func updateLocation(_ location: Location) {
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to update location: \(error.localizedDescription)"
        }
    }
    
    // DELETE LOCATION
    func deleteLocation(_ location: Location) {
        dataService.delete(location)
        
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to delete location: \(error.localizedDescription)"
        }
    }

}
