//
//  ChartFIlter.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 20/11/25.
//

import SwiftUI

class ChartFilterState: ObservableObject {
    @Published var startDate: Date = Calendar.current.date(byAdding: .month,value: -6, to: Date.now) ?? Date.now
    @Published var endDate: Date = Date()
    
    @Published var selectedFishFamilies: Set<UUID> = []
    
    @Published var selectedLocations: Set<String> = []
    @Published var selectedSites: Set<String> = []
    
    @Published var minDepth: Double = 0
    @Published var maxDepth: Double = 30
    
    func reset() {
        startDate = Calendar.current.date(byAdding: .month,value: -6, to: Date.now) ?? Date.now
        endDate = Date()
        
        selectedFishFamilies.removeAll()
        
        selectedLocations.removeAll()
        selectedSites.removeAll()
        
        minDepth = 0
        maxDepth = 30
    }
}
