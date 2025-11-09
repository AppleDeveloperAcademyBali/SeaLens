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
    
    var recentUploads: [Footage] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
        
}
