//
//  FootageTagsData.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import SwiftData
import Foundation

final class FootageTagsData {
    private let dataService: DataService
    
    var footageTags: [FootageTag] = []
    var errorMessage: String?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // Basic CRUD Operations

    // RETRIEVE FOOTAGE TAGS
    func retrieveFootageTags() async {
        errorMessage = nil
        
        do {
            let sortDescriptors = [SortDescriptor(\FootageTag.name)]
            footageTags = try await dataService.retrieve(FootageTag.self, predicate: nil, sortBy: sortDescriptors)
        } catch {
            errorMessage = "Failed to retrieve footage tags: \(error.localizedDescription)"
        }
    }
    
    func retrieveFootageTags(predicate: Predicate<FootageTag>? = nil, sortBy: [SortDescriptor<FootageTag>]?) async {
        errorMessage = nil
        
        do {
            footageTags = try await dataService.retrieve(FootageTag.self, predicate: predicate, sortBy: sortBy!)
        } catch {
            errorMessage = "Failed to retrieve footage tags: \(error.localizedDescription)"
        }
    }
    
    // CREATE FOOTAGE TAGS
    func addFootageTag(footageTag: FootageTag) async {
        
        await dataService.insert(footageTag)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to add footage tag: \(error.localizedDescription)"
        }
    }
    
    // UPDATE FOOTAGE TAGS
    func updateFootageTag(_ footageTag: FootageTag) async {
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to update footage tags: \(error.localizedDescription)"
        }
    }
    
    // DELETE FOOTAGE TAGS
    func deleteFootageTag(_ footageTag: FootageTag) async {
        await dataService.delete(footageTag)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to delete footage tags: \(error.localizedDescription)"
        }
    }

}
