//
//  FishFamilyOvertimeChartContentView.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 12/11/25.
//

import SwiftUI
import Charts

struct FishFamilyOvertimeChartView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State var seriesChartData: [SeriesOvertimeChart] = []
    @State var selectedFilters: [String: Any]
    @State var selectedDate: Date?
    @State var selectedFamily: String?
    @State var selectedColor: Color?
    @State var selectedValue: Int?
    @State var hoverLocation: CGPoint?
    
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
                    lineMarkView(for: point, family: familyData.seriesName)
                }
            }
            
            // Rule mark for vertical line
            if let selectedDate {
                RuleMark(x: .value("Date", selectedDate))
                    .foregroundStyle(.gray.opacity(0.3))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5, 5]))
            }
        }
        .chartOverlay { chartProxy in
            GeometryReader { geometry in
                Rectangle()
                    .fill(.clear)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                handleHover(at: value.location, in: geometry, chartProxy: chartProxy)
                            }
                            .onEnded { _ in
                                clearSelection()
                            }
                    )
                    .onContinuousHover { phase in
                        switch phase {
                        case .active(let location):
                            hoverLocation = location
                            handleHover(at: location, in: geometry, chartProxy: chartProxy)
                        case .ended:
                            hoverLocation = nil
                            clearSelection()
                        }
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
        .overlay(alignment: .topLeading) {
            if let selectedFamily, let selectedDate, let selectedColor {
                OvertimeAnnotationView(
                    selectedFamilyName: selectedFamily,
                    selectedDate: selectedDate,
                    selectedColor: selectedColor,
                    selectedFilters: selectedFilters,
                    modelContext: modelContext
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
                .animation(.easeInOut(duration: 0.15), value: selectedDate)
            }
        }
    }
    
    @ChartContentBuilder
    private func lineMarkView(for point: DateDataPoint, family: String) -> some ChartContent {
        LineMark(
            x: .value("Date", point.date),
            y: .value("Count", point.value)
        )
        .foregroundStyle(by: .value("Family", family))
        .symbol(Circle())
        .symbolSize(80)
    }
    
    private func handleHover(at location: CGPoint, in geometry: GeometryProxy, chartProxy: ChartProxy) {
        guard let plotFrame = chartProxy.plotFrame else { return }
        
        let xPosition = location.x - geometry[plotFrame].origin.x
        let yPosition = location.y - geometry[plotFrame].origin.y
        
        // Check if we're within the plot area
        guard xPosition >= 0, xPosition <= geometry[plotFrame].width,
              yPosition >= 0, yPosition <= geometry[plotFrame].height else {
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
        
        // Only update if we found a reasonably close point
        if closestDistance < 10, // Adjust threshold as needed
           let family = closestFamily,
           let value = closestValue,
           let pointDate = closestDate {
            
            // Force update by setting to nil first if changing
            if selectedFamily != family || selectedDate != pointDate {
                selectedFamily = nil
                selectedValue = nil
                selectedDate = nil
                selectedColor = nil
                
                // Update with new values
                DispatchQueue.main.async {
                    selectedFamily = family
                    selectedValue = value
                    selectedDate = pointDate
                    selectedColor = getColorForFamily(family)
                }
            }
        }
    }
    
    private func clearSelection() {
        withAnimation(.easeOut(duration: 0.1)) {
            selectedDate = nil
            selectedFamily = nil
            selectedColor = nil
            selectedValue = nil
        }
    }
    
    private func getColorForFamily(_ family: String) -> Color {
        // Map family names to colors - adjust based on your chart's color scheme
        let colors: [Color] = [.blue, .green, .orange, .red, .purple, .pink, .yellow, .cyan]
        let index = abs(family.hashValue) % colors.count
        return colors[index]
    }
}


