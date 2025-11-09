//
//  RecentUploadsRepository.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 28/10/25.
//

import Foundation
import SwiftData

final class RecentUploadsPersistence: RecentUploadsPersistenceProtocol {
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchAllRecentUploads() throws -> [Footage] {
        do {
            let descriptor = FetchDescriptor<Footage>(sortBy: [SortDescriptor(\.dateTaken, order: .reverse)])
            return try modelContext.fetch(descriptor)
        }
        catch {
            print("Failed to fetch recent uploads: \(error)")
            return []
        }
    }
    
}
