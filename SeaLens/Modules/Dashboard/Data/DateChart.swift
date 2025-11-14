//
//  ChartDateData.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 09/11/25.
//

import Foundation

struct DateChart: Identifiable {
    var name: Date
    var value: Int
    
    var id: Date { name }
}
