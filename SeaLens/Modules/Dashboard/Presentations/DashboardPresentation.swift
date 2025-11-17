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
    @State private var isLoading: Bool = true
    
    @State var filters: [String: Any] = [:]
    @State var isInspectorPresented: Bool = true
    @State var seriesChartData: [SeriesOvertimeChart] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.dashboardViewModel = DashboardViewModel(modelContext: modelContext)
    }

    public var body: some View  {
        VStack(alignment: .leading) {            
            headerSection
            
            chartCardView
            
            Spacer()
            
        }
        .padding()
        .onAppear() {
            Task {
                isLoading = true
                filters = dashboardViewModel.collectFilterInput(
                    startDate: Calendar.current.date(byAdding: .month,value: -4, to: Date.now) ?? Date.now,
                    endDate: Date.now,
                    selectedFishFamilies: ["Damselfish","Wrasse","Butterflyfish","Surgeonfish"],
                    selectedLocation: ["Nusa Dua","Menjangan","Tulamben","Amed"],
                    selectedSites: ["Site 1", "Site 2", "Site 3", "Site 4", "Site 5", "Site 6", "Site 7", "Site 8", "Site 9", "Site 10"],
                    minDepth: 0,
                    maxDepth: 100)
                
                seriesChartData = await dashboardViewModel.processChartOvertimeData(filters: filters)
                isLoading = false
            }
        }
        .inspector(isPresented: $isInspectorPresented) {
            Text("This is inspector view")
        }
        
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Dashboard")
                .textstyles(.title1Emphasized)
        }
    }
    
    private var chartCardView: some View {
        VStack(alignment: .center, spacing: 12) {
            if isLoading {
                ProgressView()
                    .frame(height: 350)
            } else {
                chartTitleSection
                
                Divider()
                
                chartContentView
            }
            
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
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Fish Family Population Trends Over Time")
                    .textstyles(.title1Medium)
                
                Text("Tracks the total number of fish counted for each family across all your observations. Each line represents one fish family. Higher points mean more fish of that family were observed during that time period.")
                    .textstyles(.title3Regular)
                    .foregroundColor(.secondary)
                
                Text("Showing 5 of 12 families based on 300 observations")
                    .textstyles(.title3Regular)
                    .italic()
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "arrow.down.to.line")
                    .resizable()
                    .frame(width: 20, height: 25)
                    .foregroundColor(Color("CoreColor-DarkBlue"))
            }
            .padding()
            .frame(width: 40, height: 40)
            .buttonStyle(.borderless)
            .glassEffect()

        }
        .padding()
    }
    
    @ViewBuilder
    private var chartContentView: some View {
        if seriesChartData.isEmpty {
            emptyStateView
        } else {
            FishFamilyOvertimeChartView(seriesChartData: seriesChartData, selectedFilters: filters)
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

