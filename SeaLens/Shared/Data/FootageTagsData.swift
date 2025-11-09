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
    
    var footageTags: [FootageTags] = []
    var errorMessage: String?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // Basic CRUD Operations

    // RETRIEVE FOOTAGE TAGS
    func retrieveFootageTags() async {
        errorMessage = nil
        
        do {
            let sortDescriptors = [SortDescriptor(\FootageTags.name)]
            footageTags = try await dataService.retrieve(FootageTags.self, predicate: nil, sortBy: sortDescriptors)
        } catch {
            errorMessage = "Failed to retrieve footage tags: \(error.localizedDescription)"
        }
    }
    
    func retrieveFootageTags(predicate: Predicate<FootageTags>? = nil, sortBy: [SortDescriptor<FootageTags>]?) async {
        errorMessage = nil
        
        do {
            footageTags = try await dataService.retrieve(FootageTags.self, predicate: predicate, sortBy: sortBy!)
        } catch {
            errorMessage = "Failed to retrieve footage tags: \(error.localizedDescription)"
        }
    }
    
    // CREATE FOOTAGE TAGS
    func addFootageTag(footageTag: FootageTags) async {
        
        await dataService.insert(footageTag)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to add footage tag: \(error.localizedDescription)"
        }
    }
    
    // UPDATE FOOTAGE TAGS
    func updateFootageTag(_ footageTag: FootageTags) async {
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to update footage tags: \(error.localizedDescription)"
        }
    }
    
    // DELETE FOOTAGE TAGS
    func deleteFootageTag(_ footageTag: FootageTags) async {
        await dataService.delete(footageTag)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to delete footage tags: \(error.localizedDescription)"
        }
    }

}
