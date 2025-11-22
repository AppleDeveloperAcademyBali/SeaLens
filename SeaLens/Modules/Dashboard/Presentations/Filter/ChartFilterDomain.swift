//
//  ChartFilterViewModel.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 20/11/25.
//

import SwiftData
import Foundation

class ChartFilterDomain: ObservableObject {
    private let modelContext: ModelContext
    private let fishFamilyRefData: FishFamilyReferenceData
    private let footageData: FootageData
    private let fishFamilyData: FishFamilyData
    private let locationData: LocationData
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        
        let dataService = DataService(modelContainer: modelContext.container)
        self.fishFamilyRefData = FishFamilyReferenceData(dataService: dataService)
        self.footageData = FootageData(dataService: dataService)
        self.fishFamilyData = FishFamilyData(dataService: dataService)
        self.locationData = LocationData(dataService: dataService)
    }
    
    func getFishFamilies() async -> [FamilyForChartFilter] {
        var result: [FamilyForChartFilter] = []
        var fishFamiliesData: [FishFamilyReference] = []
        let fixedFishFamilies = Array(ChartConstants.focusedFishFamily.keys)
        
        // Get all 12 Fish Families with 0 count from master table
        let sortBy = [SortDescriptor(\FishFamilyReference.commonName)]
        let predicate = #Predicate<FishFamilyReference> { family in
            fixedFishFamilies.contains(family.commonName)
        }
        fishFamiliesData = await fishFamilyRefData.retrieveFishFamilyReferences(predicate: predicate, sortBy: sortBy)
        result = convertRefDataToFilter(fishFamiliesData)
        
        // Get Total number of fish for each family
        for family in result {
            let commonName = family.commonName
            let sortDescriptor = [SortDescriptor(\FishFamily.dateCreated)]
            let filter = #Predicate<FishFamily> { fish in
                fish.fishFamilyReference?.commonName == commonName
            }
            let fish = await fishFamilyData.retrieveFishFamilies(predicate: filter, sortBy: sortDescriptor)
            
            let totalFishCount = Int(fish.reduce(0) { (result, data) in
                result + data.numOfFishDetected
            })
            
            family.totalFishCount += totalFishCount
            family.color = ChartConstants.focusedFishFamily[commonName] ?? .red
        }
        
        return result
    }
    
    func convertRefDataToFilter(_ refData: [FishFamilyReference]) -> [FamilyForChartFilter] {
        var result: [FamilyForChartFilter] = []
        
        for reference in refData {
            let item = FamilyForChartFilter(uid: reference.uid, latinName: reference.latinName, commonName: reference.commonName)
            item.isSelected = true
            
            result.append(item)
        }
        
        return result
    }
    
    func getLocations() async -> [LocationForChartFilter] {
        var result: [LocationForChartFilter] = []
        
        // Retrieve Locations
        let sortBy = [SortDescriptor(\Location.name)]
        let locationsDataResult = await locationData.retrieveLocations(sortBy: sortBy)
        let locationData: Set<String>
        switch locationsDataResult {
            case .success(let data):
            locationData = Set(data.map { $0.name })
            case .failure:
                locationData = Set<String>()
        }
        
        // Retrieve Sites
        for location in locationData {
            let sortDescriptor = [SortDescriptor(\Footage.siteName)]
            let predicate = #Predicate<Footage> { $0.locationName == location }
            let footageResult = await footageData.retrieveFootages(predicate: predicate, sortBy: sortDescriptor)
            
            let footagesData: [Footage]
            switch footageResult {
            case .success(let data):
                footagesData = data
            case .failure:
                footagesData = []
            }
            
            let siteList = Set(footagesData.map { $0.siteName })
            var sitesForChart: [SiteForChartFilter] = []
            
            for site in siteList {
                let item = SiteForChartFilter(site: site)
                item.isSelected = true
                
                sitesForChart.append(item)
            }
            
            let locationForChart = LocationForChartFilter(location: location, sites: sitesForChart)
            locationForChart.isSelected = true
            
            result.append(locationForChart)
        }
        
        return result
    }
}
