//
//  SiteData.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import SwiftData
import Foundation

@Observable
final class SiteData {
    private let dataService: DataService
    
    var sites: [Site] = []
    var errorMessage: String?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // Basic CRUD Operations

    // RETRIEVE SITE
    func retrieveAllSite() {
        errorMessage = nil
        
        do {
            let sortDescriptors = [SortDescriptor(\Site.name, order: .reverse)]
            sites = try dataService.retrieve(Site.self, predicate: nil, sortBy: sortDescriptors)
        } catch {
            errorMessage = "Failed to retrieve sites: \(error.localizedDescription)"
        }
    }
    
    func retrieveSite(predicate: Predicate<Site>? = nil, sortBy: [SortDescriptor<Site>]?) {
        errorMessage = nil
        
        do {
            sites = try dataService.retrieve(Site.self, predicate: predicate, sortBy: sortBy!)
        } catch {
            errorMessage = "Failed to retrieve sites: \(error.localizedDescription)"
        }
    }
    
    // CREATE SITE
    func addSite(site: Site) {
        
        dataService.insert(site)
        
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to add site: \(error.localizedDescription)"
        }
    }
    
    // UPDATE SITE
    func updateSite(_ site: Site) {
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to update site: \(error.localizedDescription)"
        }
    }
    
    // DELETE SITE
    func deleteSite(_ site: Site) {
        dataService.delete(site)
        
        do {
            try dataService.save()
        } catch {
            errorMessage = "Failed to delete site: \(error.localizedDescription)"
        }
    }

}
