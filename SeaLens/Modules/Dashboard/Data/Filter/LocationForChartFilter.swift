//
//  LocationForChartFilter.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 20/11/25.
//

import SwiftUI

class LocationForChartFilter: ObservableObject, Identifiable {
    var uid: UUID = UUID()
    var location: String
    var sites: [SiteForChartFilter]
    
    @Published var isSelected: Bool = false
    
    init(location: String, sites: [SiteForChartFilter]) {
        self.location = location
        self.sites = sites
    }
}
