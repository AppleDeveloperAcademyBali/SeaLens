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
    
    func processOvertimeChartData(for filters: ChartFilterState) async -> (chartData: [SeriesOvertimeChart], footageUids: Set<UUID>)
    {
        // Get list of month in specified date range
        let startDate = filters.startDate
        let endDate = filters.endDate
        
        let months = getListOfMonths(startDate: startDate, endDate: endDate)
        
        // Filter the data based on selected value
        let sortDescriptors = [SortDescriptor(\FishFamily.fishFamilyReference?.commonName)]
        let predicate = getPredicate(for: filters)
        let allFishFamilies = await retrieveFishFamilies(predicate: predicate, sortBy: sortDescriptors)
        
        let fishFamiliesToShow = filters.selectedFishFamilies
        
        let selectedFishFamilies = allFishFamilies.filter { fishFamily in
            let fishFamilyUid = fishFamily.fishFamilyReference?.uid ?? UUID()
            
            return fishFamiliesToShow.contains(fishFamilyUid)
        }
        
        var seriesChartData: [SeriesOvertimeChart] = []
        var footagesUids: Set<UUID> = []
        
        for family in selectedFishFamilies {
            guard let familyRef = family.fishFamilyReference else { continue }
            
            let footage = family.footage
            
            footagesUids.insert(footage.uid
            )
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
                return (seriesChartData, footagesUids)
            }
            
            // Get existing array and append
            if let index = seriesChartData.firstIndex(where: { $0.seriesName == familyRef.commonName }) {
                if let subIndex = seriesChartData[index].chartData.firstIndex(where: { $0.date == dateTaken }) {
                    seriesChartData[index].chartData[subIndex].value += Int(family.numOfFishDetected)
                }
            }
        }
        return (seriesChartData, footagesUids)
    }
    
    private func getPredicate(for filters: ChartFilterState) -> Predicate<FishFamily>? {
        let startDate = filters.startDate
        let endDate = filters.endDate
        
        let minDepth = filters.minDepth
        let maxDepth = filters.maxDepth
        
        let selectedLocations = filters.selectedLocations
        let selectedSites = filters.selectedSites
        
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
        selectedFilters: ChartFilterState) async -> (targetFishFamilies: [FishFamily], keyInsights: [String])
    {
        let customFilters = ChartFilterState()
        customFilters.startDate = selectedMonth
        customFilters.endDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedMonth) ?? selectedMonth.addingTimeInterval(3600 * 24 * 30)
        
        customFilters.selectedLocations = selectedFilters.selectedLocations
        customFilters.selectedSites = selectedFilters.selectedSites
        customFilters.minDepth = selectedFilters.minDepth
        customFilters.maxDepth = selectedFilters.maxDepth
        
        let fishFamiliesToShow = [selectedFishFamily]
        
        let predicate = getPredicate(for: customFilters)
        
        // Filter the data based on selected value (except for FishFamily to simplify the predicate)
        let sortDescriptors = [SortDescriptor(\FishFamily.footage.locationName)]
        let allFishFamilies = await retrieveFishFamilies(predicate: predicate, sortBy: sortDescriptors)
        
        let selectedFishFamilies = allFishFamilies.filter { fishFamily in
            let commonName = fishFamily.fishFamilyReference?.commonName ?? ""
            
            return fishFamiliesToShow.contains(commonName)
        }
        
        let insights = await generateKeyInsight(from: customFilters, selectedFishFamilies: fishFamiliesToShow, currentMonthFish: selectedFishFamilies)
        
        return (selectedFishFamilies, insights)
    }
    
    func generateKeyInsight(from filterState: ChartFilterState, selectedFishFamilies: [String], currentMonthFish: [FishFamily]) async -> [String] {
        var result: [String] = []
        
        // Get Last Month FishFamily recorded
        let filter = filterState
        filter.endDate = filter.startDate
        filter.startDate = Calendar.current.date(byAdding: .month, value: -1, to: filter.startDate) ?? filter.startDate.addingTimeInterval(-3600 * 24 * 30)
        
        let predicate = getPredicate(for: filter)
        let sortDescriptors = [SortDescriptor(\FishFamily.footage.locationName)]
        let allLastMonthFish = await retrieveFishFamilies(predicate: predicate, sortBy: sortDescriptors)
        let lastMonthFish = allLastMonthFish.filter { fishFamily in
            let commonName = fishFamily.fishFamilyReference?.commonName ?? ""
            
            return selectedFishFamilies.contains(commonName)
        }
    
        // Generate Growth Insight
        var keyInsight = generateFishGrowth(currentMonthFishList: currentMonthFish, lastMonthFishList: lastMonthFish, lastMonth: filter.startDate)
        result.append(keyInsight)
        
        // Generate Location Insight
        keyInsight = generateLocationInsight(currentMonthFishList: currentMonthFish)
        result.append(keyInsight)
        
        //Generate Depth Insight
        keyInsight = generateDepthInsight(currentMonthFishList: currentMonthFish)
        result.append(keyInsight)
        
        return result
    }
    
    private func generateDepthInsight(currentMonthFishList: [FishFamily]) -> String {
        let depthFishFamily: [(depthInMeter: String, totalFishCount: Int)] = currentMonthFishList.map { item in
            (depthInMeter: String(format: "%.2f", item.footage.depthInMeter), totalFishCount: Int(item.numOfFishDetected))
        }

        let totalsByDepth = depthFishFamily.reduce(into: [String: Int]()) { result, item in
            result[item.depthInMeter, default: 0] += item.totalFishCount
        }
        
        let sortedTotalsByDepth = totalsByDepth.sorted { $0.value > $1.value }
        
        let depthValue = sortedTotalsByDepth.first?.key ?? "0.00"
        let mostFishCount = sortedTotalsByDepth.first?.value ?? 0
        
        let keyInsight = "Most common at \(depthValue)m depth (\(mostFishCount) fish)"
        
        return keyInsight
    }
    
    private func generateLocationInsight(currentMonthFishList: [FishFamily]) -> String {
        let totalFishCount = currentMonthFishList.reduce(0) { count, fishFamily in
            count + fishFamily.numOfFishDetected
        }
        
        let locationFishFamily: [(location: String, totalFishCount: Int)] = currentMonthFishList.map { item in
            (location: item.footage.locationName, totalFishCount: Int(item.numOfFishDetected))
        }

        let totalsByLocation = locationFishFamily.reduce(into: [String: Int]()) { result, item in
            result[item.location, default: 0] += item.totalFishCount
        }
        
        let sortedTotalsByLocation = totalsByLocation.sorted { $0.value > $1.value }
        
        let locationName = sortedTotalsByLocation.first?.key ?? "Unknown"
        let mostFishCount = sortedTotalsByLocation.first?.value ?? 0
        
        let keyInsight = "\(Int((Double(mostFishCount)/Double(totalFishCount)) * 100))%  found in \(locationName) (\(mostFishCount) fish)"
        
        return keyInsight
    }
    
    private func generateFishGrowth(currentMonthFishList: [FishFamily], lastMonthFishList: [FishFamily], lastMonth: Date) -> String {
        let currentMonthFishCount = currentMonthFishList.reduce(0) { count, fishFamily in
            count + fishFamily.numOfFishDetected
        }
        let lastMonthFishCount = lastMonthFishList.reduce(0) { count, fishFamily in
            count + fishFamily.numOfFishDetected
        }
        
        let diffCount = currentMonthFishCount - lastMonthFishCount
        let percentageChange: Int = lastMonthFishCount == 0 ? 100 : abs(Int((Double(diffCount) / Double(lastMonthFishCount)) * 100))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        
        let month = formatter.string(from: lastMonth)
        
        var result = "No change from \(month)"
        if diffCount > 0 {
            result = "\(percentageChange)% increase from \(month) (\(diffCount) fish)"
        } else if diffCount < 0 {
            result = "\(percentageChange)% decrease from \(month) (\(diffCount) fish)"
        }
        
        return result
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
        
        var currentDateComponents = calendar.dateComponents([.year, .month], from: startDate)
        currentDateComponents.day = 1
        var currentDate = calendar.date(from: currentDateComponents) ?? Date()
        
        var endDateComponents = calendar.dateComponents([.year, .month], from: endDate)
        endDateComponents.day = 1
        let endMonthDate = calendar.date(from: endDateComponents) ?? Date()
        
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
