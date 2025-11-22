//
//  SeriesOvertimeChart.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 09/11/25.
//

import Foundation
import SwiftUI

struct SeriesOvertimeChart: Identifiable {
    var seriesName: String
    var chartData: [DateDataPoint]
    var seriesColor: Color = .blue
    
    var id : String { seriesName }
}
