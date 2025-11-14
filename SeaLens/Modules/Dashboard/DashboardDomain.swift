//
//  DashboardDomain.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 09/11/25.
//

import Foundation
import SwiftData

class DashboardDomain: ObservableObject {
    private let modelContext: ModelContext
    private let fishFamilyData: FishFamilyData
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fishFamilyData = FishFamilyData(dataService: DataService(modelContainer: modelContext.container))
        
        Task {
            await fishFamilyData.retrieveFishFamilies()
        }
    }
    
    func convertToChartData(source: [Footage]) -> [SeriesChart] {
        var seriesCharts: [SeriesChart] = []
        
        for footage in source {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"
            
            let formattedDate = dateFormatter.string(from: footage.dateTaken)
            
            for fishFamily in footage.fishFamily {
                var commonName = "Unidentified"
                if let reference = fishFamily.fishFamilyReference {
                    commonName = reference.commonName
                }
                
                let chartData = StringChart(name: formattedDate, value: Int(fishFamily.numOfFishDetected))
                
                // Check if Series is exist
                if let index = seriesCharts.firstIndex( where: { $0.seriesName == commonName } ) {
                    var existingChartData = seriesCharts[index].chartData
                    existingChartData.append(chartData)
                    seriesCharts[index] = .init(seriesName: commonName, chartData: existingChartData)
                } else {
                    seriesCharts.append(SeriesChart(seriesName: commonName, chartData: [chartData]))
                }
    
            }
        }
        
        return seriesCharts
    }
}
