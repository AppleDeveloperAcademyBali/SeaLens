//
//  DashboardView.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 25/10/2025.
//

import SwiftUI
import SwiftData
import Charts

public struct DashboardPresentation: View {
    @State private var modelContext: ModelContext
    @State private var dashboardViewModel: DashboardViewModel
    
    @State var seriesChartData: [SeriesOvertimeChart] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.dashboardViewModel = DashboardViewModel(modelContext: modelContext)
    }

    public var body: some View  {
        VStack(alignment: .leading) {
            debugButtons
            
            headerSection
            
            chartCardView
            
            Spacer()
            
        }
        .padding()
        .onAppear() {
            Task {
                seriesChartData = await dashboardViewModel.processChartOvertimeData(
                    startDate: Calendar.current.date(byAdding: .month,value: -3, to: Date.now) ?? Date.now,
                    endDate: Date.now,
                    selectedFishFamilies: [],
                    selectedLocation: [],
                    selectedSites: [],
                    minDepth: 0,
                    maxDepth: 0)
            }
        }
        
    }
    
    @ViewBuilder
    private var debugButtons: some View {
        #if DEBUG
        HStack {
            Button("Generate Dummy Data") {
                DummyDataService.generateDummyData(context: modelContext)
            }
            
            Button("Delete All Data") {
                DummyDataService.deleteAllData(context: modelContext)
            }
        }
        #endif
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Dashboard")
                .textstyles(.title1Emphasized)
            
            HStack {
                Text("Based on 300 observations")
                    .textstyles(.title3Regular)
                    .italic()
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Button {
                    // Export Charts
                } label: {
                    Text("Export all charts")
                        .textstyles(.bodyEmphasized)
                        .frame(height: 25)
                }
                .buttonStyle(.glass)
            }
        }
    }
    
    private var chartCardView: some View {
        VStack(alignment: .center, spacing: 12) {
            chartTitleSection
            
            Divider()
            
            chartContentView
            
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: StrokeStyle(lineWidth: 1))
                .foregroundColor(.gray)
                .opacity(0.5)
        }
    }
    
    private var chartTitleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Fish Family Population Trends Over Time")
                .textstyles(.title1Medium)
            
            Text("Tracks the total number of fish counted for each family across all your observations. Each line represents one fish family. Higher points mean more fish of that family were observed during that time period.")
                .textstyles(.title3Regular)
                .foregroundColor(.secondary)
        }
    }
    
    @ViewBuilder
    private var chartContentView: some View {
        if seriesChartData.isEmpty {
            emptyStateView
        } else {
            FishFamilyOvertimeChartView(seriesChartData: seriesChartData)
        }
    }
    
    private var emptyStateView: some View {
        ContentUnavailableView(
            "No Data Available",
            systemImage: "chart.line.uptrend.xyaxis",
            description: Text("Upload some observations to see fish family population trends over time.")
        )
    }
}

