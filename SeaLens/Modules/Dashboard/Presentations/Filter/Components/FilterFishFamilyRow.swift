//
//  FilterFishFamilyRow.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 19/11/25.
//

import SwiftUI

struct FilterFishFamilyRow: View {
    @ObservedObject var family: FamilyForChartFilter
    var onSelectionChanged: (() -> Void)?
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                withAnimation {
                    family.isSelected.toggle()
                    onSelectionChanged?()
                }
            } label: {
                Image(systemName: family.isSelected ? "checkmark.square.fill" : "square")
                    .foregroundColor(family.isSelected ? .blue : .gray)
                    .font(.system(size: 20))
            }
            .buttonStyle(.plain)
            
            ColorCode(color: family.color, title: family.commonName, subtitle: "􀋃 \(family.totalFishCount) total")
        }
    }
}


#Preview {
    @Previewable @StateObject var family = FamilyForChartFilter(uid: UUID(), latinName: "Labridae", commonName: "Wrasse")
    
    FilterFishFamilyRow(family: family)
}
