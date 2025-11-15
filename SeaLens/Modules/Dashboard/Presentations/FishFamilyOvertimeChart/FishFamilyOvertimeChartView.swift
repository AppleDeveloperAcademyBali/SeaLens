//
//  FishFamilyOvertimeChartContentView.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 12/11/25.
//

import SwiftUI
import Charts

struct FishFamilyOvertimeChartView: View {
    @State var seriesChartData: [SeriesOvertimeChart] = []
    @State var selectedMonth: String?
    @State var selectedDate: Date?
    @State var selectedFamily: String?
    
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
            if let selectedDate {
                PointMark(x: .value("Month", selectedDate))
                    .foregroundStyle(.primary)
                    .annotation {
                        OvertimeAnnotationView(selectedFamilyName: "Snapper", selectedDate: selectedDate, selectedColor: Color.blue)
                    }
                
                
            }
        }
        .chartXSelection(value: $selectedDate)
        .chartOverlay { (chartProxy: ChartProxy) in
            Color.clear
                .onContinuousHover { hoverPhase in
                    switch hoverPhase {
                    case .active(let hoverLocation):
                         if let date: Date = chartProxy.value(atX: hoverLocation.x, as: Date.self)
                        {
                             selectedDate = date
                         }
                        selectedMonth = chartProxy.value(atX: hoverLocation.x, as: String.self)
                    case .ended:
                        selectedMonth = nil
                        selectedDate = nil
                    }
                }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .month)) { value in
                if let date = value.as(Date.self) {
                    AxisValueLabel {
                        Text(date, format: .dateTime.month(.abbreviated).year())
                            //.rotationEffect(Angle.degrees(-45))
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
    }
    
    @ChartContentBuilder
    private func lineMarkView(for point: DateDataPoint, family: String) -> some ChartContent {
        LineMark(
            x: .value("Date", point.date),
            y: .value("Count", point.value)
        )
        .foregroundStyle(by: .value("Family", family))
        .symbol(Circle())
    }
    
    @ChartContentBuilder
    private func pointMarkView(for point: DateDataPoint, family: String) -> some ChartContent {
        PointMark(
            x: .value("Date", point.date),
            y: .value("Count", point.value)
        )
        .foregroundStyle(by: .value("Family", family))
    }
}

