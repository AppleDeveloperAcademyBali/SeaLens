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
    private let footageData: FootageData
    private let fishFamilyData: FishFamilyData
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        footageData = FootageData(dataService: DataService(modelContainer: modelContext.container))
        fishFamilyData = FishFamilyData(dataService: DataService(modelContainer: modelContext.container))
        
        Task {
            await footageData.retrieveFootages()
        }
    }
    
    func retrieveFishFamilies(predicate: Predicate<FishFamily>?, sortBy: [SortDescriptor<FishFamily>]) async -> [FishFamily] {
        return await fishFamilyData.retrieveFishFamilies(predicate: predicate, sortBy: sortBy)
    }
    
    func retrieveFootages(predicate: Predicate<Footage>?, sortBy: [SortDescriptor<Footage>]) async -> [Footage] {
        return await footageData.retrieveFootages(predicate: predicate, sortBy: sortBy)
    }
    
    func processOvertimeChartData(
        startDate: Date,
        endDate: Date,
        selectedFishFamilies: [String],
        selectedLocation: [String],
        selectedSites: [String],
        minDepth: Double,
        maxDepth: Double) async -> [SeriesOvertimeChart]
    {
        // Get list of month in specified date range
        let months = getListOfMonths(startDate: startDate, endDate: endDate)
        
        // Filter the data based on selected value
        let sortDescriptors = [SortDescriptor(\FishFamily.fishFamilyReference?.commonName)]
        let selectedFishFamilies = await retrieveFishFamilies(predicate: nil, sortBy: sortDescriptors)
        
        var seriesChartData: [SeriesOvertimeChart] = []
        
        for family in selectedFishFamilies {
            guard let familyRef = family.fishFamilyReference,
                  let footage = family.footage else { continue }
            
            for fishFamily in footage.fishFamily ?? [] {
                var commonName = "Unidentified"
                if let reference = fishFamily.fishFamilyReference {
                    commonName = reference.commonName
                }
            // Check if no fish family in array
            // Create 0 data point to fish that is not detected / have 0 value
            if !seriesChartData.contains(where: { $0.seriesName == familyRef.commonName })
            {
                var dataPoints : [DateDataPoint] = []
                
                for month in months {
                    let point = DateDataPoint(date: month, value: 0, monthOfYear: formatMonthYear(month))
                    dataPoints.append(point)
                }
                
                seriesChartData.append(SeriesOvertimeChart(seriesName: familyRef.commonName, chartData: dataPoints))
            }
            
            // Append real data
            let calendar = Calendar.current
            guard let dateTaken = calendar.date(from: calendar.dateComponents([.year, .month], from: footage.dateTaken)) else {
                return seriesChartData
            }
        
            // Get existing array and append
            if let index = seriesChartData.firstIndex(where: { $0.seriesName == familyRef.commonName }) {
                if let subIndex = seriesChartData[index].chartData.firstIndex(where: { $0.date == dateTaken }) {
                    seriesChartData[index].chartData[subIndex].value += Int(family.numOfFishDetected)
                }
            }
            
        }
        
        return seriesChartData
    }
    
    private func getPredicate(
        startDate: Date,
        endDate: Date,
        selectedFishFamilies: [String],
        selectedLocation: [String],
        selectedSites: [String],
        minDepth: Double,
        maxDepth: Double) -> Predicate<FishFamily>?
    {
        //TODO: Construct Predicate based on filter selected
        
        return nil
    }
    
    private func getListOfMonths(startDate: Date, endDate: Date) -> [Date] {
        // Get list of Month & Year in selected range
         let calendar = Calendar.current
         var months: [Date] = []
         
         guard var currentDate = calendar.date(from: calendar.dateComponents([.year, .month], from: startDate)) else {
             return months
         }
         
         guard let endMonthDate = calendar.date(from: calendar.dateComponents([.year, .month], from: endDate)) else {
             return months
         }
         
         while currentDate <= endMonthDate {
             months.append(currentDate)
             
             guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: currentDate) else {
                 break
             }
             currentDate = nextMonth
         }
        
        return months
    }
    
    private func formatMonthYear(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: date)
    }

}
