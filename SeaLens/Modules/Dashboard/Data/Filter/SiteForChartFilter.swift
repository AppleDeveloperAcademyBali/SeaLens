//
//  SiteForChartFilter.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 21/11/25.
//

import SwiftUI

class SiteForChartFilter: ObservableObject, Identifiable {
    var uid: UUID = UUID()
    var site: String
    @Published var isSelected: Bool = false
    
    init(site: String) {
        self.site = site
    }
}
