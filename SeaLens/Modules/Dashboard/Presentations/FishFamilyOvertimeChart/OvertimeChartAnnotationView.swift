//
//  DataPointHoverView.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 12/11/25.
//

import SwiftUI
import SwiftData
import Charts

struct OvertimeChartAnnotationView: View {
    @StateObject private var initialNavigationViewModel = InitialNavigationViewModel()
    @ObservedObject private var filterState: ChartFilterState
    
    @State var selectedFamilyName: String
    @State var selectedDate: Date
    @State var selectedColor: Color
    @State var dashboardViewModel: DashboardViewModel
    
    @State var colorCodeSubtitle: String = ""
    @State var buttonTitle: String = ""
    @State var chartData: [StringDataPoint] = []
    @State var footages: Set<UUID> = []
    
    @State private var isLoading: Bool = true
    
    var onDismiss: () -> Void
    
    init(
        selectedFamilyName: String,
        selectedDate: Date,
        selectedColor: Color,
        filters: ChartFilterState,
        modelContext: ModelContext,
        onDismiss: @escaping () -> Void)
    {
        self.selectedFamilyName = selectedFamilyName
        self.selectedDate = selectedDate
        self.selectedColor = selectedColor
        self.filterState = filters
        self.dashboardViewModel = DashboardViewModel(modelContext: modelContext)
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if isLoading {
                ProgressView()
                    .frame(height: 350)
            } else {
                HStack(alignment: .top) {
                    ColorCode(
                        color: selectedColor,
                        title: dashboardViewModel.getTitleForAnnotation(fishFamily: selectedFamilyName, selectedMonth: selectedDate) ,
                        subtitle: colorCodeSubtitle)
                    
                    Spacer()
                    
                    Button(action: onDismiss) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(.plain)
                }
                
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
                NavigationLink(
                    destination: RecentUploadsPresentation(initialNavigationViewModel: initialNavigationViewModel,
                    selectedFootageUID: footages))
                {
                    HStack {
                        Text(buttonTitle)
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
                isLoading = true
                let result = await dashboardViewModel.processFamilyOverLocationChartData(selectedMonth: selectedDate, selectedFishFamily: selectedFamilyName, selectedFilters: filterState)
                
                chartData = result.chartData
                colorCodeSubtitle = result.subtitle
                buttonTitle = result.buttonTitle
                footages = result.footages
                isLoading = false
            }
        }
    }
}
