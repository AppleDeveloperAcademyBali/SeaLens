//
//  StringDataPoint.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 15/11/25.
//

import Foundation

struct StringDataPoint: Identifiable {
    var name: String
    var value: Int
    
    var id: UUID = UUID()
}
