//
//  RecentUploadsViewModel.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftData
import Observation

@Observable
class RecentUploadsViewModel: ObservableObject {
    private let persistence: RecentUploadsPersistence
    
    var recentUploads: [Footage] = []
    
    init(persistence: RecentUploadsPersistence) {
        self.persistence = persistence
    }
    
    func fetchRecentUploads() {
        do {
            recentUploads = try persistence.fetchAllRecentUploads()
        }
        catch {
            print("Failed to fetch recent uploads: \(error)")
        }
    }
        
}
