//
//  RecentUploadDomain.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import Foundation
import SwiftData

class RecentUploadsDomain: ObservableObject {
    let modelContext: ModelContext
    let footageData: FootageData
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        footageData = FootageData(dataService: DataService(modelContainer: modelContext.container))
        
        Task {
            await footageData.retrieveFootages()
        }
    }
 
    func retrieveFootages() -> [Footage] {
        return footageData.footages
    }
    
}
