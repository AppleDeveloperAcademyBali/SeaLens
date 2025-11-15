//
//  SwiftUIView.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 12/11/25.
//

import SwiftUI

struct ColorCode: View {
    @State var color: Color
    @State var title: String
    @State var subtitle: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            // Vertical bar
            RoundedRectangle(cornerRadius: 4)
                .fill(color)
                .frame(width: 6, height: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .textstyles(.bodyMedium)
                    .foregroundColor(.primary)

                Text(subtitle)
                    .textstyles(.caption1Regular)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
    }
}

#Preview {
    ColorCode(color: .blue, title: "Snapper", subtitle: "􀋃 346 total")
}
