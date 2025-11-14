//
//  DashboardViewModel.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 09/11/25.
//

import Foundation
import SwiftData

class DashboardViewModel: ObservableObject {
    private let modelContext: ModelContext
    private let dashboardDomain: DashboardDomain
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.dashboardDomain = DashboardDomain(modelContext: modelContext)
    }
    
    func convertToDate(_ text: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.date(from: text)
    }
    
    func convertToChartData(source: [Footage]) -> [SeriesChart] {
        return dashboardDomain.convertToChartData(source: source)
    }
}
