//
//  DateDataPoint.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 12/11/25.
//

import Foundation

struct DateDataPoint: Identifiable, Equatable {
    var date: Date
    var value: Int
    var monthOfYear: String
    
    var id: UUID = UUID()
}
