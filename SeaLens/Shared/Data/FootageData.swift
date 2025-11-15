//
//  Footage.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import SwiftData
import Foundation

final class FootageData {
    private let dataService: DataService
    
    var footages: [Footage] = []
    var errorMessage: String?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // Basic CRUD Operations

    // RETRIEVE FOOTAGE
    func retrieveFootages() async {
        errorMessage = nil
        
        do {
            let sortDescriptors = [SortDescriptor(\Footage.dateTaken, order: .reverse)]
            footages = try await dataService.retrieve(Footage.self, predicate: nil, sortBy: sortDescriptors)
        } catch {
            errorMessage = "Failed to retrieve footages: \(error.localizedDescription)"
        }
    }
    
    func retrieveFootages(predicate: Predicate<Footage>? = nil, sortBy: [SortDescriptor<Footage>]) async -> Result<[Footage], Error> {
        
        do {
            footages = try await dataService.retrieve(Footage.self, predicate: predicate, sortBy: sortBy)
            return .success(footages)
        } catch (let error) {
            errorMessage = "Failed to retrieve footages: \(error.localizedDescription)"
            return .failure(error)
        }
    }
    
    func retrieveFootages(predicate: Predicate<Footage>? = nil, sortBy: [SortDescriptor<Footage>]) async -> [Footage] {
        errorMessage = nil
        var footageList: [Footage] = []
        
        do {
            footageList = try await dataService.retrieve(Footage.self, predicate: predicate, sortBy: sortBy)
        } catch {
            errorMessage = "Failed to retrieve footages: \(error.localizedDescription)"
        }
        
        return footageList
    }
    
    // CREATE FOOTAGE
    func addFootage(footage: Footage) async {
        
        await dataService.insert(footage)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to add footage: \(error.localizedDescription)"
        }
    }
    
    // UPDATE FOOTAGE
    func updateFootage(_ footage: Footage) async {
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to update footage: \(error.localizedDescription)"
        }
    }
    
    // DELETE FOOTAGE
    func deleteFootage(_ footage: Footage) async {
        await dataService.delete(footage)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to delete footage: \(error.localizedDescription)"
        }
    }

}
