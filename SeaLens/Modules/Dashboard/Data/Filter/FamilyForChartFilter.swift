//
//  FamilyForChartFilter.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 20/11/25.
//

import SwiftUI

class FamilyForChartFilter: ObservableObject, Identifiable {
    var uid: UUID
    var latinName: String
    var commonName: String
    
    var totalFishCount: Int = 0
    @Published var isSelected: Bool = false
    var color: Color = .blue
    
    init(uid: UUID, latinName: String, commonName: String) {
        self.uid = uid
        self.latinName = latinName
        self.commonName = commonName
    }
}
