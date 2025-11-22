//
//  ChartInspectorViewModel.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 20/11/25.
//

import SwiftData
import Foundation

class ChartFilterViewModel: ObservableObject {
    private var modelContext: ModelContext
    private var domain: ChartFilterDomain
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        
        self.domain = ChartFilterDomain(modelContext: modelContext)
    }
    
    func getFishFamilies() async  -> [FamilyForChartFilter] {
        return await domain.getFishFamilies()
    }
    
    func getLocations() async -> [LocationForChartFilter] {
        return await domain.getLocations()
    }
}
