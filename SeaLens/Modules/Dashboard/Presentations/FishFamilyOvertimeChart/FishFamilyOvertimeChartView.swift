//
//  FishFamilyOvertimeChartContentView.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 12/11/25.
//

import SwiftUI
import SwiftData
import Charts

struct FishFamilyOvertimeChartView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State var seriesChartData: [SeriesOvertimeChart] = []
    @State var selectedFilters: [String: Any] = [:]
    /*@State private var selectedDate: Date?
    @State private var selectedFamily: String?
    @State private var selectedColor: Color?
    @State private var selectedValue: Int?*/
    
    @State private var persistentSelectedPoint: DateDataPoint?
    @State private var persistentSelectedFamily: String?
    @State private var persistentSelectedColor: Color?
    
    private var overtimeViewModel = OvertimeViewModel()
    
    init(seriesChartData: [SeriesOvertimeChart], selectedFilters: [String: Any]) {
        self.seriesChartData = seriesChartData
        self.selectedFilters = selectedFilters
    }
    
    var body: some View {
        VStack {
            if seriesChartData.isEmpty {
                ContentUnavailableView(
                    "No Data Available",
                    systemImage: "chart.line.uptrend.xyaxis",
                    description: Text("Add footage with fish detections to see the chart")
                )
            } else {
                chartView
            }
        }
    }
    
    @ViewBuilder
    private var chartView: some View {
        Chart {
            ForEach(seriesChartData) { familyData in
                ForEach(familyData.chartData) { point in
                    lineMarkChart(point, familyData)
                }
            }
            
            // Rule mark for vertical line - Use persistent state
            if let selectedDate = persistentSelectedPoint?.date {
                RuleMark(x: .value("Date", selectedDate))
                    .foregroundStyle(.gray.opacity(0.5))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5, 5]))
            }
        }
        .chartOverlay { chartProxy in
            GeometryReader { geometry in
                Rectangle()
                    .fill(.clear)
                    .contentShape(Rectangle())
                    .gesture(
                        SpatialTapGesture()
                            .onEnded { event in
                                handleTap(at: event.location , in: geometry, chartProxy: chartProxy)
                            }
                    )
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
        .overlay(alignment: .topLeading) {
            if let selectedFamily = persistentSelectedFamily,
               let selectedPoint = persistentSelectedPoint,
               let selectedColor = persistentSelectedColor
            {
                OvertimeAnnotationView(
                    selectedFamilyName: selectedFamily,
                    selectedDate: selectedPoint.date,
                    selectedColor: selectedColor,
                    selectedFilters: selectedFilters,
                    modelContext: modelContext,
                    onDismiss: { clearSelection() }
                )
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                )
                .padding(.leading, 40)
                .padding(.top, 20)
                .transition(.opacity.combined(with: .scale(scale: 0.95)))
                .animation(.easeInOut(duration: 0.15), value: selectedFamily)
                .animation(.easeInOut(duration: 0.15), value: selectedPoint.date)
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
            if persistentSelectedPoint == point && persistentSelectedFamily == familyData.seriesName {
                Circle()
                    .fill(persistentSelectedColor ?? .clear)
                    .frame(width: 15, height: 15)
                    .shadow(radius: 3)
            } else {
                Circle()
                    .fill(overtimeViewModel.getColorForFamily(familyData.seriesName))
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
            clearSelection()
            return
        }
        
        guard let date: Date = chartProxy.value(atX: xPosition, as: Date.self),
              let yValue: Double = chartProxy.value(atY: yPosition, as: Double.self) else {
            return
        }
        
        findClosestDataPoint(to: date, yValue: yValue)
    }
    
    private func findClosestDataPoint(to date: Date, yValue: Double) {
        var closestDistance = Double.infinity
        var closestFamily: String?
        var closestValue: Int?
        var closestDate: Date?
        
        // Find the closest point considering both X (date) and Y (value) distance
        for familyData in seriesChartData {
            for point in familyData.chartData {
                // Normalize time distance (in days)
                let timeDistance = abs(point.date.timeIntervalSince(date)) / (24 * 3600)
                
                // Value distance
                let valueDistance = abs(Double(point.value) - yValue)
                
                // Combined distance (weighted)
                let combinedDistance = timeDistance + valueDistance * 0.5
                
                if combinedDistance < closestDistance {
                    closestDistance = combinedDistance
                    closestFamily = familyData.seriesName
                    closestValue = point.value
                    closestDate = point.date
                }
            }
        }
        
        if closestDistance < 10,
           let family = closestFamily,
           let value = closestValue,
           let pointDate = closestDate {
            
            // Update persistent state with animation
            withAnimation(.easeInOut(duration: 0.15)) {
                persistentSelectedFamily = family
                persistentSelectedPoint = DateDataPoint(date: pointDate, value: value, monthOfYear: ChartConstants.formatMonthYear(pointDate))
                persistentSelectedColor = overtimeViewModel.getColorForFamily(family)
            }
        }
    }
    
    private func clearSelection() {
        withAnimation(.easeOut(duration: 0.1)) {
            persistentSelectedPoint = nil
            persistentSelectedFamily = nil
            persistentSelectedColor = nil
        }
    }

}


