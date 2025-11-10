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
    
    @State var seriesChart: [SeriesChart] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.dashboardViewModel = DashboardViewModel(modelContext: modelContext)
    }

    public var body: some View  {
        VStack(alignment: .leading) {
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
            
            VStack(alignment: .leading) {
                Text("Number of Fish Species Grouped by Fish Family Over Time")
                    .textstyles(.title1Medium)
                
                Text("Shows how many different species were found within each fish family during different time periods. Higher points on each line mean more diverse species were observed in that family during that month.")
                    .textstyles(.title3Regular)
                    .foregroundColor(.secondary)
                
                Divider()
                
                Chart {
                    ForEach(seriesChart) { series in
                        ForEach(series.chartData) { data in
                            LineMark(
                                x: .value("Period of Time", data.name),
                                y: .value("No of Fish", data.value)
                            )
                            .foregroundStyle(by: .value("Fish Family", series.seriesName))
                        }
                    }
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
        .padding()
        .onAppear() {
            seriesChart = dashboardViewModel.convertToChartData(source: Footage.sampleData)
        }
        
    }
}

