//
//  ChartData.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 09/11/25.
//

import Foundation

struct StringChart: Identifiable {
    var name: String
    var value: Int
    
    var id: String { name }
}
