//
//  DashboardViewModel.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 09/11/25.
//

import Foundation
import SwiftData

class DashboardViewModel: ObservableObject {
    private let modelContext: ModelContext
    private let dashboardDomain: DashboardDomain
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.dashboardDomain = DashboardDomain(modelContext: modelContext)
    }
    
    func convertToDate(_ text: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.date(from: text)
    }
    
    func processChartOvertimeData(
        startDate: Date,
        endDate: Date,
        selectedFishFamilies: [String],
        selectedLocation: [String],
        selectedSites: [String],
        minDepth: Double,
        maxDepth: Double) async -> [SeriesOvertimeChart]
    {
        return await dashboardDomain.processOvertimeChartData(
            startDate: startDate,
            endDate: endDate,
            selectedFishFamilies: selectedFishFamilies,
            selectedLocation: selectedLocation,
            selectedSites: selectedSites,
            minDepth: minDepth,
            maxDepth: maxDepth)
    }
    
    func processChartData(chartType: ChartType) async -> [SeriesOvertimeChart] {
        return []
    }
    
    /*private func findNearestPoint(at location: CGPoint, in geometry: GeometryProxy, proxy: ChartProxy) {
        // Find the nearest data point to cursor
        guard let plotArea = proxy.plotAreaFrame else { return }
        
        // This is a simplified approach - you may need to adjust based on your needs
        let xPosition = location.x - plotArea.origin.x
        let relativeX = xPosition / plotArea.width
        
        // Find closest data point based on x position
        if !chartData.isEmpty {
            let index = min(max(Int(relativeX * Double(chartData.count)), 0), chartData.count - 1)
            selectedPoint = chartData[index]
        }
    }*/
}
