//
//  OvertimeViewModel.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 17/11/25.
//

import Foundation
import SwiftUI

class OvertimeViewModel: ObservableObject {
    func getColorForFamily(_ family: String) -> Color {
        let colors: [Color] = [.blue, .green, .orange, .red, .purple, .pink, .yellow, .cyan]
        let index = abs(family.hashValue) % colors.count
        return colors[index]
    }
}
