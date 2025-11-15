//
//  SeriesOvertimeChart.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 09/11/25.
//

import Foundation

struct SeriesOvertimeChart: Identifiable {
    var seriesName: String
    var chartData: [DateDataPoint]
    
    var id : String { seriesName }
}
