//
//  MetadataDetailComponent.swift
//  SeaLens
//
//  Created by Handy Handy on 06/11/25.
//

import SwiftUI

struct MetadataDetailComponent: View {
    var title: String = "Title"
    var subtitle: String = "Subtitle"
    var body: some View {
        VStack (alignment: .leading, spacing: 8) {
            Text(title)
                .textstyles(.caption1Regular)
            Text(subtitle)
                .textstyles(.caption1Regular)
                .foregroundStyle(.secondary)
                .padding(.bottom, 16)
        }
    }
}

#Preview {
    MetadataDetailComponent()
}
