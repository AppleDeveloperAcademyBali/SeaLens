//
//  Location.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import SwiftData
import Foundation

final class LocationData {
    private let dataService: DataService
    
    var locations: [Location] = []
    var errorMessage: String?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // Basic CRUD Operations

    // RETRIEVE LOCATION
    func retrieveLocations() async -> Result<[Location], Error> {
        do {
            let sortDescriptors = [SortDescriptor(\Location.name)]
            locations = try await dataService.retrieve(Location.self, predicate: nil, sortBy: sortDescriptors)
            return .success(locations)
        } catch {
            return .failure(error)
        }
    }
    
    func retrieveLocations(
        predicate: Predicate<Location>? = nil,
        sortBy: [SortDescriptor<Location>]?) async -> Result<[Location], Error> {
        do {
            locations = try await dataService.retrieve(Location.self, predicate: predicate, sortBy: sortBy ?? [SortDescriptor(\Location.name)])
            return .success(locations)
        } catch {
            return .failure(error)
        }
    }
    
    // CREATE LOCATION
    func addLocation(location: Location) async {
        
        await dataService.insert(location)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to add location: \(error.localizedDescription)"
        }
    }
    
    // UPDATE LOCATION
    func updateLocation(_ location: Location) async {
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to update location: \(error.localizedDescription)"
        }
    }
    
    // DELETE LOCATION
    func deleteLocation(_ location: Location) async {
        await dataService.delete(location)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to delete location: \(error.localizedDescription)"
        }
    }

}
