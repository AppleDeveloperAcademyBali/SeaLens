//
//  HoverPressButtonStyle.swift
//  SeaLens
//
//  Created by Handy Handy on 17/11/25.
//

import SwiftUI

struct HoverPressButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HoverPressButton(configuration: configuration)
    }

    private struct HoverPressButton: View {
        let configuration: Configuration
        @State private var isHovered = false

        var body: some View {
            let targetScale: CGFloat = configuration.isPressed
                ? 0.9          // clicked
                : (isHovered ? 1.005 : 1.0)  // hover / normal

            configuration.label
                .scaleEffect(targetScale)
                .animation(.spring(response: 0.1,
                                   dampingFraction: 0.5,
                                   blendDuration: 0.1),
                           value: targetScale)
                .onHover { hover in
                    isHovered = hover
                }
        }
    }
}
