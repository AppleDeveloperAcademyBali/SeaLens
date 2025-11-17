//
//  DataPointHoverView.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 12/11/25.
//

import SwiftUI
import SwiftData
import Charts

struct OvertimeAnnotationView: View {
    @State var selectedFamilyName: String
    @State var selectedDate: Date
    @State var selectedColor: Color
    @State var selectedFilters: [String: Any]
    @State var dashboardViewModel: DashboardViewModel
    
    @State var chartData: [StringDataPoint] = []
    
    init(
        selectedFamilyName: String,
        selectedDate: Date,
        selectedColor: Color,
        selectedFilters: [String: Any],
        modelContext: ModelContext)
    {
        self.selectedFamilyName = selectedFamilyName
        self.selectedDate = selectedDate
        self.selectedColor = selectedColor
        self.selectedFilters = selectedFilters
        self.dashboardViewModel = DashboardViewModel(modelContext: modelContext)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ColorCode(
                color: selectedColor,
                title: dashboardViewModel.getTitleForAnnotation(fishFamily: selectedFamilyName, selectedMonth: selectedDate) ,
                subtitle: dashboardViewModel.getSubtitleForAnnotation())
            
            // TODO: Key Insight
            //Text("KEY INSIGHT")
            //    .textstyles(.caption1Regular)
            
            Divider()
            
            Text("LOCATION BREAKDOWN")
                .textstyles(.caption1Regular)
            
            // Bar Chart for each location
            Chart(chartData) { dataPoint in
                BarMark (
                    x: .value("Number of Fish", dataPoint.value),
                    y: .value("Location", dataPoint.name)
                )
            }
            .padding()
            .frame(height: 200)
            
            //Link to Recents Observations
            NavigationLink(destination: FishCollectionView()) {
                HStack {
                    Text(dashboardViewModel.getButtonTitleForAnnotation())
                        .textstyles(.bodyMedium)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 30)
                .background(Color.blue)
                .cornerRadius(25)
                .buttonStyle(.plain)
                .foregroundStyle(Color.blue)
            }
            .buttonStyle(.borderless)
        }
        .padding()
        .frame(width: 550)
        .overlay {
            RoundedRectangle(cornerRadius: 32)
                .stroke(style: StrokeStyle(lineWidth: 1))
                .foregroundColor(.gray)
        }
        .onAppear() {
            Task {
                chartData = await dashboardViewModel.processFamilyOverLocationChartData(selectedMonth: selectedDate, selectedFishFamily: selectedFamilyName, selectedFilters: selectedFilters)
            }
        }
    }
}
