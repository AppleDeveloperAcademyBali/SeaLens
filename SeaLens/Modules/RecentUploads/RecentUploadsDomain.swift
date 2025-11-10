//
//  RecentUploadDomain.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import Foundation
import SwiftData

@Observable
class RecentUploadsDomain: ObservableObject {
    let modelContext: ModelContext
    let footageData: FootageData
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        footageData = FootageData(dataService: DataService(modelContainer: modelContext.container))
    }
 
    func retrieveFootages() async -> [Footage] {
        await footageData.retrieveFootages()
        return footageData.footages
    }
    
}
