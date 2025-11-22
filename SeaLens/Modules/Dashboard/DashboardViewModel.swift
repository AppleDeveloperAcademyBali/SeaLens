//
//  DashboardViewModel.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 09/11/25.
//

import SwiftUI
import Foundation
import SwiftData

class DashboardViewModel: ObservableObject {
    private let modelContext: ModelContext
    private let dashboardDomain: DashboardDomain
    
    var fishFamiliesOverLocationData: [FishFamily] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.dashboardDomain = DashboardDomain(modelContext: modelContext)
    }
    
    func convertToDate(_ text: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.date(from: text)
    }
    
    func getColorForFamily(_ family: String) -> Color {
        if let color = ChartConstants.focusedFishFamily[family] {
            return color
        }
        
        return Color.red
    }
    
    func collectFilterInput(
        startDate: Date,
        endDate: Date,
        selectedFishFamilies: [String],
        selectedLocation: [String],
        selectedSites: [String],
        minDepth: Double,
        maxDepth: Double
    ) -> [String: Any] {
        var filters: [String: Any] = [:]
        
        filters["startDate"] = startDate
        filters["endDate"] = endDate
        filters["selectedFishFamilies"] = selectedFishFamilies
        filters["selectedLocations"] = selectedLocation
        filters["selectedSites"] = selectedSites
        filters["minDepth"] = minDepth
        filters["maxDepth"] = maxDepth
        
        return filters
    }
    
    func processChartOvertimeData(for filterState: ChartFilterState) async -> (chartData: [SeriesOvertimeChart], footageUids: Set<UUID>)
    {
        return await dashboardDomain.processOvertimeChartData(for: filterState)
    }
    
    func processChartData(chartType: ChartType) async -> [SeriesOvertimeChart] {
        return []
    }
    
    func processFamilyOverLocationChartData(
        selectedMonth: Date,
        selectedFishFamily: String,
        selectedFilters: ChartFilterState) async -> (chartData: [StringDataPoint], subtitle: String, buttonTitle: String, footages: Set<UUID>)
    {
        fishFamiliesOverLocationData = await dashboardDomain.retrieveFishFamiliesOverLocationData(selectedMonth: selectedMonth, selectedFishFamily: selectedFishFamily, selectedFilters: selectedFilters)
        
        let chartData = dashboardDomain.processFamilyOverLocationChartData(fishFamilies: fishFamiliesOverLocationData)
        
        var numOfFish = 0
        var numOfObservations = 0
        var allFootages = Set<UUID>()
        
        if !fishFamiliesOverLocationData.isEmpty {
            allFootages = Set(fishFamiliesOverLocationData.map { $0.footage.uid })
            numOfObservations = allFootages.count
            
            numOfFish = Int(fishFamiliesOverLocationData.reduce(0) { (result, data) in
                result + data.numOfFishDetected
            })
        }
        
        let subtitie = "\(numOfFish) total fish, \(numOfObservations) total observations"
        let buttonTitle = "View \(numOfObservations) observations"
        
        return (chartData, subtitie, buttonTitle, allFootages)
    }
    
    func getTitleForAnnotation(
        fishFamily: String,
        selectedMonth: Date) -> String
    {
        return "\(fishFamily) - \(ChartConstants.formatMonthYear(selectedMonth))"
    }
    
    func getSubtitleForAnnotation() -> String {
        var numOfFish = 0
        var numOfObservations = 0
        
        if !fishFamiliesOverLocationData.isEmpty {
            let allFootages = fishFamiliesOverLocationData.map { $0.footage.uid }
            numOfObservations = Set(allFootages).count
            
            numOfFish = Int(fishFamiliesOverLocationData.reduce(0) { (result, data) in
                result + data.numOfFishDetected
            })
        }
        
        return "\(numOfFish) total fish counted (from \(numOfObservations) observations)"
    }
    
    func getButtonTitleForAnnotation() -> String {
        var numOfObservations = 0
        
        if !fishFamiliesOverLocationData.isEmpty {
            let allFootages = fishFamiliesOverLocationData.map { $0.footage.uid }
            numOfObservations = Set(allFootages).count
        }
        
        return "View \(numOfObservations) observations"
    }

}
