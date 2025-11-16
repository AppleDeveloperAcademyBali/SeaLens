//
//  RecentUploadsViewModel.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftData
import Observation

@MainActor
class RecentUploadsViewModel: ObservableObject {
    @Injected private var recentuploadDomain: RecentUploadsDomain
    
    @Published var footages: [Footage] = []
    private var allFootages: [Footage] = []
    
    @Published var searchText: String = ""
        
    func loadFootages() async
    {
        allFootages = await recentuploadDomain.retrieveFootages()
        footages = allFootages
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
        if searchText.isEmpty {
            footages = allFootages
        } else {
            footages = allFootages.filter { $0.filename.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
