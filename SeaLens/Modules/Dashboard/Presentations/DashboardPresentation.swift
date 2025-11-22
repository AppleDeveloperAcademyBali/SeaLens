//
//  DashboardView.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 25/10/2025.
//

import SwiftUI
import SwiftData
import Charts

public struct DashboardPresentation: View {
    @StateObject var dashboardViewModel: DashboardViewModel
    @StateObject private var filterState = ChartFilterState()
    
    @State private var modelContext: ModelContext
    @State private var isLoading: Bool = true
    
    @State var isInspectorPresented: Bool = true
    @State var seriesChartData: [SeriesOvertimeChart] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self._dashboardViewModel = StateObject(wrappedValue: DashboardViewModel(modelContext: modelContext))
    }

    public var body: some View  {
        VStack(alignment: .leading, spacing: 8) {
            Text("Dashboard")
                .textstyles(.title1Emphasized)
            
            chartContentView
            
            Spacer()
            
        }
        .padding()
        .inspector(isPresented: $isInspectorPresented) {
            ChartFilterFormView(modelContext: modelContext, filters: filterState)
                .toolbar {
                    Button {
                        isInspectorPresented.toggle()
                    } label: {
                        Label("Show/Hide Filters", systemImage: isInspectorPresented ? "chevron.right" : "chevron.backward")
                    }
                    Spacer()
                }
        }
    }
    
    private var chartContentView: some View {
        VStack(alignment: .center, spacing: 12) {
            OvertimeChartView(viewModel: dashboardViewModel, filters: filterState)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: StrokeStyle(lineWidth: 1))
                .foregroundColor(.gray)
                .opacity(0.5)
        }
    }
}

