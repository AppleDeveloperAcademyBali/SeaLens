//
//  SiteData.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import SwiftData
import Foundation

final class SiteData {
    private let dataService: DataService
    
    var sites: [Site] = []
    var errorMessage: String?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // Basic CRUD Operations

    // RETRIEVE SITE
    func retrieveSites() async -> Result<[Site], any Error> {
        do {
            let sortDescriptors = [SortDescriptor(\Site.name)]
            sites = try await dataService.retrieve(Site.self, predicate: nil, sortBy: sortDescriptors)
            return .success(sites)
        } catch {
            return .failure(error)
        }
    }
    
    func retrieveSites(predicate: Predicate<Site>? = nil, sortBy: [SortDescriptor<Site>]?) async -> Result<[Site], any Error>  {
        do {
            sites = try await dataService.retrieve(Site.self, predicate: predicate, sortBy: sortBy!)
            return .success(sites)
        } catch {
            return .failure(error)
        }
    }
    
    // CREATE SITE
    func addSite(site: Site) async {
        
        await dataService.insert(site)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to add site: \(error.localizedDescription)"
        }
    }
    
    // UPDATE SITE
    func updateSite(_ site: Site) async {
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to update site: \(error.localizedDescription)"
        }
    }
    
    // DELETE SITE
    func deleteSite(_ site: Site) async {
        await dataService.delete(site)
        
        do {
            try await dataService.save()
        } catch {
            errorMessage = "Failed to delete site: \(error.localizedDescription)"
        }
    }

}
