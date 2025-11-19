//
//  ChartConstants.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 17/11/25.
//

import Foundation
import SwiftUI

struct ChartConstants {
    static let focusedFishFamily: [String: Color] = [
        "Angelfish": Color(hex: "1F94FF"),
        "Batfish": Color(hex: "3CC3DF"),
        "Butterflyfish": Color(hex: "FF928A"),
        "Damselfish": Color(hex: "2BB7DC"),
        "Goatfish": Color(hex: "8C63DA"),
        "Grouper": Color(hex: "55C4AE"),
        "Parrotfish": Color(hex: "F4CF3B"),
        "Rabbitfish": Color(hex: "6186CC"),
        "Snapper": Color(hex: "6FD195"),
        "Surgeonfish": Color(hex: "8979FF"),
        "Sweetlips": Color(hex: "FFAE4C"),
        "Wrasse": Color(hex: "537FF1")
    ]
    
    static func formatMonthYear(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: date)
    }
}
