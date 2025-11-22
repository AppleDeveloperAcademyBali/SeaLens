//
//  ChartInspectorFormView.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 19/11/25.
//

import SwiftUI
import SwiftData
import Combine

struct ChartFilterFormView: View {
    @State private var showDatePicker: Bool = false
    @State private var showFishFamilies: Bool = true
    @State private var showLocations: Bool = true
    
    @State private var fishFamilies: [FamilyForChartFilter] = []
    @State private var locations: [LocationForChartFilter] = []
    
    @State private var chartFilterViewModel: ChartFilterViewModel
    @State private var isLoading: Bool = false
    @State private var cancellables = Set<AnyCancellable>()
    
    @ObservedObject var filterState: ChartFilterState
    
    private var selectedFamilyCount: Int {
        filterState.selectedFishFamilies.count
    }
    
    private var dateRangeText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return "\(formatter.string(from: filterState.startDate)) - \(formatter.string(from: filterState.endDate))"
    }
    
    init(modelContext: ModelContext, filters: ChartFilterState) {
        self.chartFilterViewModel = ChartFilterViewModel(modelContext: modelContext)
        self.filterState = filters
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Filters")
                    .textstyles(.bodyEmphasized)
                    .bold()
                    .padding(.bottom, 10)
                
                Button() {
                    // Reset Filters
                    resetFilters()
                } label: {
                    Text("Reset")
                        .textstyles(.bodyEmphasized)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color.white)
                        .cornerRadius(25)
                }
                .glassEffect()
                .buttonStyle(.borderless)
                
                Divider()
                    .padding()
                
                DateRangeSection
                
                Divider()
                    .padding()
                
                FishFamilySection
                
                Divider()
                    .padding()
                
                LocationSection
                
                Divider()
                    .padding()
                
                DepthRangeSection
                
            }
            .padding(.horizontal)
            .onAppear() {
                Task {
                    isLoading = true
                    
                    fishFamilies = await chartFilterViewModel.getFishFamilies()
                    locations = await chartFilterViewModel.getLocations()
                    getInitialChartFilterState()
                    
                    isLoading = false
                }
            }
        }
    }
    
    func getInitialChartFilterState() {
        for family in fishFamilies {
            handleFamilySelectionChange(family)
        }
        
        for location in locations {
            handleLocationSelectionChange(location)
            
            for site in location.sites {
                handleSiteSelectionChange(site)
            }
        }
    }
    
    private var LocationSection: some View {
        VStack(alignment: .leading) {
            Button {
                showLocations.toggle()
            } label: {
                HStack {
                    Text("Locations")
                        .textstyles(.caption1Emphasized)
                        .foregroundColor(.primary)
                        .bold()
                    Spacer()
                    Image(systemName: showLocations ? "chevron.down" : "chevron.right")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.secondary)
                }
            }
            .buttonStyle(.plain)
            .padding(.bottom, 8)
            
            if showLocations {
                ForEach(locations) { location in
                    FilterLocationRow(location: location) {
                        handleLocationSelectionChange(location)
                    } onSiteSelectionChanged: { site in
                        handleSiteSelectionChange(site)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .glassEffect()
    }
    
    private var DateRangeSection: some View {
        // Date Range
        VStack(alignment: .leading, spacing: 8) {
            Text("Date Range")
                .textstyles(.caption1Emphasized)
            
            Button {
                showDatePicker.toggle()
            } label: {
                HStack {
                    Text(dateRangeText)
                        .textstyles(.bodyMedium)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.secondary)
                }
                .frame(height: 44)
                .background(Color.white)
                .cornerRadius(10)
            }
            .glassEffect()
            .buttonStyle(.borderless)
            
            if showDatePicker {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("From")
                            .textstyles(.caption1Regular)
                        DatePicker("", selection: $filterState.startDate, displayedComponents: .date)
                            .textstyles(.bodyMedium)
                            .labelsHidden()
                            
                    }
                    
                    VStack(alignment: .leading) {
                        Text("To")
                            .textstyles(.caption1Regular)
                        DatePicker("", selection: $filterState.endDate, displayedComponents: .date)
                            .textstyles(.bodyMedium)
                            .labelsHidden()
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .glassEffect()
    }
    
    @ViewBuilder
    private var FishFamilySection: some View {
        // FIsh Families
        VStack(alignment: .leading, spacing: 0) {
            Button {
                showFishFamilies.toggle()
            } label: {
                HStack {
                    Text("Fish families (\(selectedFamilyCount) of \(fishFamilies.count))")
                        .textstyles(.caption1Emphasized)
                        .foregroundColor(.primary)
                        .bold()
                    Spacer()
                    Image(systemName: showFishFamilies ? "chevron.down" : "chevron.right")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.secondary)
                }
            }
            .buttonStyle(.plain)
            
            if showFishFamilies {
                Text("Click checkboxes to show/hide. Use 'Show only' to isolate.")
                    .textstyles(.caption1Regular)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 4)
                
                // Display list of fish families
                if isLoading {
                    ProgressView()
                }
                else {
                    ForEach(fishFamilies) { family in
                        FilterFishFamilyRow(family: family) {
                            handleFamilySelectionChange(family)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .glassEffect()
    }
    
    private var DepthRangeSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Depth Range")
                .textstyles(.caption1Emphasized)
            
            Text("Range: 0 - 30 m (all data)")
                .textstyles(.caption1Regular)
                .foregroundColor(.secondary)
                .italic()
            
            HStack(alignment: .top) {
                // Min Value
                VStack(alignment: .leading) {
                    Text("Min")
                        .textstyles(.caption1Regular)
                    TextField("0", value: $filterState.minDepth, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .textstyles(.caption1Regular)
                }
                
                // Max Value
                VStack(alignment: .leading) {
                    Text("Max")
                        .textstyles(.caption1Regular)
                    TextField("30", value: $filterState.maxDepth, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .textstyles(.caption1Regular)
                }
            }
            .padding()
        }
        .padding()
        .padding(.bottom, 20)
        .background(Color.white)
        .cornerRadius(10)
        .glassEffect()
        
    }
    
    private func setupFamilyObservers() {
        cancellables.removeAll()
        
        for family in fishFamilies {
            family.objectWillChange
                .sink { [weak family] _ in
                    guard let family = family else { return }
                    handleFamilySelectionChange(family)
                }
                .store(in: &cancellables)
        }
    }
    
    private func handleFamilySelectionChange(_ family: FamilyForChartFilter) {
        if family.isSelected {
            filterState.selectedFishFamilies.insert(family.uid)
        } else {
            filterState.selectedFishFamilies.remove(family.uid)
        }
    }
    
    private func handleLocationSelectionChange(_ location: LocationForChartFilter) {
        if location.isSelected {
            filterState.selectedLocations.insert(location.location)
        } else {
            filterState.selectedLocations.remove(location.location)
        }
    }
    
    private func handleSiteSelectionChange(_ site: SiteForChartFilter) {
        if site.isSelected {
            filterState.selectedSites.insert(site.site)
        } else {
            filterState.selectedSites.remove(site.site)
        }
    }
    
    private func resetFilters() {
        filterState.reset()
        
        for family in fishFamilies {
            family.isSelected = true
            
            handleFamilySelectionChange(family)
        }
        
        for location in locations {
            location.isSelected = true
            handleLocationSelectionChange(location)
            
            for site in location.sites {
                site.isSelected = true
                handleSiteSelectionChange(site)
            }
        }
    }
}
