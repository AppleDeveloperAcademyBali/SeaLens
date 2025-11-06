//
//  DropdownFieldView.swift
//  SeaLens
//
//  Created by Handy Handy on 06/11/25.
//

import SwiftUI

struct DropdownFieldComponent: View {

    var title: String = ""
    var suggestion: [String] = []
    @Binding var selectedItem: String

    var body: some View {
        VStack (alignment: .leading, spacing: 8){
            Text(title)
                .textstyles(.caption1Regular)
            ComboBox(text: $selectedItem, values: suggestion)
                .frame(width: 220)
        }
    }
}
