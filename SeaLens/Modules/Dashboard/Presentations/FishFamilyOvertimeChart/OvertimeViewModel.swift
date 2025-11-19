//
//  OvertimeViewModel.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 17/11/25.
//

import Foundation
import SwiftUI

class OvertimeChartViewModel: ObservableObject {
    func getColorForFamily(_ family: String) -> Color {
        if let color = ChartConstants.focusedFishFamily[family] {
            return color
        }
        
        return Color.red
    }
}
