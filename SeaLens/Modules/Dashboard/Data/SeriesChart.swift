//
//  SeriesChart.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 09/11/25.
//

import Foundation

struct SeriesChart: Identifiable {
    var seriesName: String
    var chartData: [StringChart]
    
    var id : String { seriesName }
}
