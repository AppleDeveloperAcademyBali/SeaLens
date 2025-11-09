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
    private let modelContext: ModelContext
    private let recentuploadDomain: RecentUploadsDomain
    
    var footages: [Footage] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.recentuploadDomain = RecentUploadsDomain(modelContext: modelContext)
    }
        
    // Retrieve All Footages
    func retrieveFootages() -> [Footage] {
        return recentuploadDomain.retrieveFootages()
    }
    
    func loadFootages()
    {
        footages = recentuploadDomain.retrieveFootages()
    }
    
    // Apply Sorting for the Presentation
    func applySorting(sortOption: SortOption)
    {
        switch sortOption {
        case .dateTakenNewest:
            footages.sort { $0.dateTaken > $1.dateTaken }
            break
        case .dateTakenOldest:
            footages.sort { $0.dateTaken < $1.dateTaken }
            break
        case .filenameAscending:
            footages.sort { $0.filename < $1.filename }
            break
        case .filenameDesscending:
            footages.sort { $0.filename > $1.filename }
            break
        }
    }
    
    // Apply Searching for the Presentation
    func applySearching(searchText: String)
    {
        footages = retrieveFootages()
        
        if !searchText.isEmpty {
            footages = footages.filter { $0.filename.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
