//
//  CustomButtonStyle.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 03/11/25.
//


import SwiftUI
import Foundation

struct CustomButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    var fontSize: CGFloat = 18
    var horizontalPadding: CGFloat = 38
    var verticalPadding: CGFloat = 19
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Figtree", size: fontSize).weight(.semibold))
            .foregroundColor(foregroundColor(for: configuration))
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .frame(maxWidth: .infinity, alignment: .center)
            //.background(backgroundColor(for: configuration))
            .cornerRadius(100)
            .shadow(color: .white.opacity(0.07), radius: 0, x: 0, y: 0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
    
    private func foregroundColor(for configuration: Configuration) -> Color {
        let disabledColor = Color(.gray)
        
        if !isEnabled {
            return disabledColor
        }
        return configuration.isPressed ? .primary : .primary
    }
    
    /*private func backgroundColor(for configuration: Configuration) -> Color {
        let baseColor = Color(red: 0.01, green: 0.38, blue: 0.68)
        
        if !isEnabled {
            return .gray
        }
        return configuration.isPressed ? baseColor.opacity(0.8) : baseColor
    }*/
}
