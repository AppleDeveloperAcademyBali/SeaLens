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
        let result = await footageData.retrieveFootages(predicate: predicate, sortBy: sortBy)
        switch result {
        case .success(let footages):
            return footages
        case .failure:
            return []
        }
    }
    
    func processOvertimeChartData(filters: [String: Any]) async -> [SeriesOvertimeChart]
    {
        // Get list of month in specified date range
        guard let startDate = filters["startDate"] as? Date,
              let endDate = filters["endDate"] as? Date else { return [] }
        
        let months = getListOfMonths(startDate: startDate, endDate: endDate)
        
        // Filter the data based on selected value
        let sortDescriptors = [SortDescriptor(\FishFamily.fishFamilyReference?.commonName)]
        let predicate = getPredicate(filters: filters)
        let allFishFamilies = await retrieveFishFamilies(predicate: predicate, sortBy: sortDescriptors)
        
        let fishFamiliesToShow = filters["selectedFishFamilies"] as? [String] ?? []
        
        let selectedFishFamilies = allFishFamilies.filter { fishFamily in
            let commonName = fishFamily.fishFamilyReference?.commonName ?? ""
            
            return fishFamiliesToShow.contains(commonName)
        }
        
        var seriesChartData: [SeriesOvertimeChart] = []
        
        for family in selectedFishFamilies {
            guard let familyRef = family.fishFamilyReference else { continue }
            
            let footage = family.footage
            
            // Check if no fish family in array
            // Create 0 data point to fish that is not detected / have 0 value
            if !seriesChartData.contains(where: { $0.seriesName == familyRef.commonName })
            {
                var dataPoints : [DateDataPoint] = []
                
                for month in months {
                    let point = DateDataPoint(date: month, value: 0, monthOfYear: formatMonthYear(month))
                    dataPoints.append(point)
                }
                
                let seriesColor = ChartConstants.focusedFishFamily[familyRef.commonName] ?? .red
                
                seriesChartData.append(SeriesOvertimeChart(seriesName: familyRef.commonName, chartData: dataPoints, seriesColor: seriesColor))
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
    
    private func getPredicate(filters: [String: Any]) -> Predicate<FishFamily>? {
        let startDate = filters["startDate"] as? Date ?? Date.now
        let endDate = filters["endDate"] as? Date ?? Date.now
        
        let minDepth = filters["minDepth"] as? Double ?? 0
        let maxDepth = filters["maxDepth"] as? Double ?? 100
        
        let selectedLocations = filters["selectedLocations"] as? [String] ?? []
        let selectedSites = filters["selectedSites"] as? [String] ?? []
        
        let predicate = #Predicate<FishFamily> { fishFamily in
            //Filter Date, Depth, Location and Site (Except FishFamilies to simplify predicates)
            (fishFamily.footage.dateTaken >= startDate && fishFamily.footage.dateTaken < endDate) &&
            (fishFamily.footage.depthInMeter >= minDepth && fishFamily.footage.depthInMeter <= maxDepth) &&
            selectedLocations.contains(fishFamily.footage.locationName) &&
            selectedSites.contains(fishFamily.footage.siteName)
        }
        
        return predicate
    }
    
    func retrieveFishFamiliesOverLocationData(
        selectedMonth: Date,
        selectedFishFamily: String,
        selectedFilters: [String: Any]) async -> [FishFamily]
    {
        var customFilters = selectedFilters
        if customFilters.index(forKey: "startDate") == nil {
            customFilters["startDate"] = Date.now
        }
        customFilters["startDate"] = selectedMonth
        
        var endDateComponent = DateComponents()
        endDateComponent.month = 1
        let endOfMonth = Calendar.current.date(byAdding: endDateComponent, to: selectedMonth) ?? selectedMonth.addingTimeInterval(3600 * 24 * 30)
        if customFilters.index(forKey: "endDate") == nil {
            customFilters["endDate"] = Date.now
        }
        customFilters["endDate"] = endOfMonth
        
        let fishFamiliesToShow = [selectedFishFamily]
        if customFilters.index(forKey: "selectedFishFamilies") == nil {
            customFilters["selectedFishFamilies"] = []
        }
        customFilters["selectedFishFamilies"] = fishFamiliesToShow
        
        let predicate = getPredicate(filters: customFilters)
        
        // Filter the data based on selected value (except for FishFamily to simplify the predicate)
        let sortDescriptors = [SortDescriptor(\FishFamily.footage.locationName)]
        let allFishFamilies = await retrieveFishFamilies(predicate: predicate, sortBy: sortDescriptors)
        
        let selectedFishFamilies = allFishFamilies.filter { fishFamily in
            let commonName = fishFamily.fishFamilyReference?.commonName ?? ""
            
            return fishFamiliesToShow.contains(commonName)
        }
        
        return selectedFishFamilies
    }
    
    func processFamilyOverLocationChartData(
        fishFamilies: [FishFamily]) -> [StringDataPoint]
    {
        var dataPoint: [StringDataPoint] = []
        
        for family in fishFamilies {
            dataPoint.append(StringDataPoint(name: family.footage.locationName, value: Int(family.numOfFishDetected)))
        }
        
        return dataPoint
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
