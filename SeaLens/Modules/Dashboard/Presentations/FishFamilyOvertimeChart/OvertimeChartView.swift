//
//  FishFamilyOvertimeChartContentView.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 12/11/25.
//

import SwiftUI
import SwiftData
import Charts

struct OvertimeChartView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var filterState: ChartFilterState
    
    @State var seriesChartData: [SeriesOvertimeChart] = []
    @State var footagesUids: Set<UUID> = []
    
    @State private var persistentSelectedPoint: DateDataPoint?
    @State private var persistentSelectedFamily: String?
    @State private var persistentSelectedColor: Color?
    
    // Store the tap location for annotation positioning
    @State private var annotationPosition: CGPoint?
    @State private var annotationData: OvertimeAnnotationData?
    @State private var annotationID = UUID()
    
    @State private var chartGeometry: GeometryProxy?
    @State private var isLoading: Bool = true
    
    @StateObject var dashboardViewModel: DashboardViewModel
    
    init(viewModel: DashboardViewModel, filters: ChartFilterState) {
        self._dashboardViewModel = StateObject(wrappedValue: viewModel)
        self.filterState = filters
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            chartTitleSection
            
            chartContentSection
        }
        .onAppear {
            loadData()
        }
        .onChange(of: filterState.startDate) { _, _ in
            loadData()
        }
        .onChange(of: filterState.endDate) { _, _ in
            loadData()
        }
        .onChange(of: filterState.selectedFishFamilies) { _, _ in
            loadData()
        }
        .onChange(of: filterState.minDepth) { _, _ in
            loadData()
        }
        .onChange(of: filterState.maxDepth) { _, _ in
            loadData()
        }
        .onChange(of: filterState.selectedLocations) { _, _ in
            loadData()
        }
        .onChange(of: filterState.selectedSites) { _, _ in
            loadData()
        }
    }
    
    func loadData() {
        Task {
            isLoading = true
            
            let result = await dashboardViewModel.processChartOvertimeData(for: filterState)
            
            await MainActor.run {
                seriesChartData = result.chartData
                footagesUids = result.footageUids
                isLoading = false
            }
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
                
                Text("Based on \(footagesUids.count) observations")
                    .textstyles(.title3Regular)
                    .italic()
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button {
                // Export Chart
                
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
    private var chartContentSection: some View {
        VStack(alignment: .center) {
            if isLoading {
                ProgressView()
            } else {
                if seriesChartData.isEmpty {
                    ContentUnavailableView(
                        "No Data Available",
                        systemImage: "chart.line.uptrend.xyaxis",
                        description: Text("Add footage with fish detections to see the chart")
                    )
                } else {
                    chartContentView
                }
            }
        }
    }
    
    @ViewBuilder
    private var chartContentView: some View {
        ZStack(alignment: .topLeading) {
            Chart {
                ForEach(seriesChartData) { familyData in
                    ForEach(familyData.chartData) { point in
                        lineMarkChart(point, familyData)
                    }
                }
                
                // Rule mark for vertical line - Use persistent state
                if let data = annotationData {
                    RuleMark(x: .value("Date", data.point.date))
                        .foregroundStyle(.gray.opacity(0.5))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5, 5]))
                }
                
            }
            .chartForegroundStyleScale(
                domain: seriesChartData.map { $0.seriesName },
                range: seriesChartData.map { $0.seriesColor })
            .chartOverlay { chartProxy in
                GeometryReader { geometry in
                    Rectangle()
                        .fill(.clear)
                        .contentShape(Rectangle())
                        .gesture(
                            SpatialTapGesture()
                                .onEnded { event in
                                    handleTap(at: event.location, in: geometry, chartProxy: chartProxy)
                                }
                        )
                        .onAppear {
                            chartGeometry = geometry
                        }
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .month)) { value in
                    if let date = value.as(Date.self) {
                        AxisValueLabel {
                            Text(date, format: .dateTime.month(.abbreviated).year())
                        }
                    }
                    AxisGridLine()
                    AxisTick()
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) { value in
                    AxisValueLabel()
                    AxisGridLine()
                }
            }
            .chartYAxisLabel("Number of Fish Detected")
            .chartLegend(position: .bottom, alignment: .leading)
            .frame(height: 300)
            .padding()
            
            // Annotation overlay with dynamic positioning
            if let data = annotationData, let geometry = chartGeometry {
                OvertimeChartAnnotationView(
                    selectedFamilyName: data.family,
                    selectedDate: data.point.date,
                    selectedColor: data.color,
                    filters: filterState,
                    modelContext: modelContext,
                    onDismiss: { annotationData = nil }
                )
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                )
                .fixedSize()
                .position(
                    x: calculateAnnotationX(position: data.position, geometry: geometry),
                    y: calculateAnnotationY(position: data.position, geometry: geometry)
                )
                .transition(.opacity.combined(with: .scale(scale: 0.95)))
            }
            
        }
    }
    
    @ChartContentBuilder
    private func lineMarkChart(_ point: DateDataPoint, _ familyData: SeriesOvertimeChart) -> some ChartContent {
        LineMark(
            x: .value("Date", point.date),
            y: .value("Count", point.value)
        )
        .foregroundStyle(by: .value("Family", familyData.seriesName))
        .symbol {
            if let data = annotationData,
               data.point == point && data.family == familyData.seriesName {
                Circle()
                    .fill(data.color)
                    .frame(width: 15, height: 15)
                    .shadow(radius: 3)
            } else {
                Circle()
                    .fill(dashboardViewModel.getColorForFamily(familyData.seriesName))
                    .frame(width: 8, height: 8)
                    .opacity(0.8)
            }
        }
    }
    
    private func handleTap(at location: CGPoint, in geometry: GeometryProxy, chartProxy: ChartProxy) {
        guard let plotFrame = chartProxy.plotFrame else { return }
        
        let xPosition = location.x - geometry[plotFrame].origin.x
        let yPosition = location.y - geometry[plotFrame].origin.y
        
        guard xPosition >= 0, xPosition <= geometry[plotFrame].width,
              yPosition >= 0, yPosition <= geometry[plotFrame].height else {
            // Tapped outside the chart area, clear selection
            annotationData = nil
            return
        }
        
        guard let date: Date = chartProxy.value(atX: xPosition, as: Date.self),
              let yValue: Double = chartProxy.value(atY: yPosition, as: Double.self) else {
            return
        }
        
        findClosestDataPoint(to: date, yValue: yValue, tapLocation: location)
    }
    
    private func findClosestDataPoint(to date: Date, yValue: Double, tapLocation: CGPoint) {
        var closestDistance = Double.infinity
        var closestFamily: String?
        var closestValue: Int?
        var closestDate: Date?
        
        for familyData in seriesChartData {
            for point in familyData.chartData {
                let timeDistance = abs(point.date.timeIntervalSince(date)) / (24 * 3600)
                let valueDistance = abs(Double(point.value) - yValue)
                let combinedDistance = timeDistance * 0.2 + valueDistance * 0.2
                
                if combinedDistance < closestDistance {
                    closestDistance = combinedDistance
                    closestFamily = familyData.seriesName
                    closestValue = point.value
                    closestDate = point.date
                }
            }
        }
        
        if closestDistance < 30,
           let family = closestFamily,
           let value = closestValue,
           let pointDate = closestDate {
            
            // Single atomic state update
            annotationData = OvertimeAnnotationData(
                point: DateDataPoint(date: pointDate, value: value, monthOfYear: ChartConstants.formatMonthYear(pointDate)),
                family: family,
                color: dashboardViewModel.getColorForFamily(family),
                position: tapLocation
            )
        } else {
            annotationData = nil
        }
    }
    
    private func calculateAnnotationX(position: CGPoint, geometry: GeometryProxy) -> CGFloat {
        let annotationWidth: CGFloat = 550 // Width from OvertimeAnnotationView
        let padding: CGFloat = 20
        
        // Try to position to the right of the cursor
        var xPos = position.x + annotationWidth / 2 + padding
        
        // If it would go off the right edge, position to the left instead
        if xPos + annotationWidth / 2 > geometry.size.width {
            xPos = position.x - annotationWidth / 2 - padding
        }
        
        // Ensure it doesn't go off the left edge
        if xPos - annotationWidth / 2 < 0 {
            xPos = annotationWidth / 2 + padding
        }
        
        return xPos
    }
    
    private func calculateAnnotationY(position: CGPoint, geometry: GeometryProxy) -> CGFloat {
        let estimatedAnnotationHeight: CGFloat = 400 // Approximate height
        let padding: CGFloat = 20
        
        // Try to center vertically around the click point
        var yPos = position.y
        
        // If it would go off the bottom, move it up
        if yPos + estimatedAnnotationHeight / 2 > geometry.size.height {
            yPos = geometry.size.height - estimatedAnnotationHeight / 2 - padding
        }
        
        // If it would go off the top, move it down
        if yPos - estimatedAnnotationHeight / 2 < 0 {
            yPos = estimatedAnnotationHeight / 2 + padding
        }
        
        return yPos
    }
    
    private func clearSelection() {
        withAnimation(.easeOut(duration: 0.1)) {
            persistentSelectedPoint = nil
            persistentSelectedFamily = nil
            persistentSelectedColor = nil
            annotationPosition = nil
            annotationID = UUID() // Add this line
        }
    }
}


