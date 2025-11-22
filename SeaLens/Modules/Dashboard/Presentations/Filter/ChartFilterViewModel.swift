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
        let fishFamilies = await domain.getFishFamilies()
        
        return selectTopFishFamily(fishFamilies, topN: 5)
    }
    
    func getLocations() async -> [LocationForChartFilter] {
        return await domain.getLocations()
    }
    
    func selectTopFishFamily(_ families: [FamilyForChartFilter], topN: Int) -> [FamilyForChartFilter] {
        var count = 0
        
        if families.count < topN {
            count = families.count
        } else {
            count = topN
        }
        
        let sortedFamilies = families.sorted { $0.totalFishCount > $1.totalFishCount }
        
        for i in 0..<count {
            sortedFamilies[i].isSelected = true
        }
        
        return sortedFamilies
    }
}
