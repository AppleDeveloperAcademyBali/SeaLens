//
//  NavigationFishCountView.swift
//  SeaLens
//
//  Created by Handy Handy on 09/11/25.
//

import SwiftUI

struct NavigationFishCountView: View {
    @MainActor var dismissClicked: () -> Void = { }
    var body: some View {
        HStack (spacing: 16) {
            Button {
                dismissClicked()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 24))
                    .padding(8)
            }
            .buttonBorderShape(.circle)
            .buttonStyle(.glass)

            VStack (alignment: .leading, spacing: 4) {
                Text("Review fish count")
                    .textstyles(.title2MediumRounded)
                Text("12 families")
                    .textstyles(.bodyRegular)
                    .opacity(0.5)
            }
        }
    }
}

#Preview {
    NavigationFishCountView()
}
