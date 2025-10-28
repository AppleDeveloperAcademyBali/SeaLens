//
//  TextStyles.swift
//  SeaLens
//
//  Created by Ghina Syafina Syahrani on 28/10/25.
//

import SwiftUI

// Text styles definition
struct TextStyles {
    let font: Font
    let lineHeight: CGFloat
    let fontSize: CGFloat
    
    var lineSpacing: CGFloat {
        lineHeight - fontSize
    }
}

extension TextStyles {
    // Large Title
    static let largeTitleEmphasized = TextStyles(
        font: .system(size: 26, weight: .bold, design: .default),
        lineHeight: 32,
        fontSize: 26
    )
    
    // Title 1
    static let title1Regular = TextStyles(
        font: .system(size: 22, weight: .regular, design: .default),
        lineHeight: 26,
        fontSize: 22
    )
    
    static let title1Medium = TextStyles(
        font: .system(size: 22, weight: .medium, design: .default),
        lineHeight: 26,
        fontSize: 22
    )
    
    static let title1Emphasized = TextStyles(
        font: .system(size: 22, weight: .bold, design: .default),
        lineHeight: 26,
        fontSize: 22
    )
    
    // Title 2
    static let title2Regular = TextStyles(
        font: .system(size: 17, weight: .regular, design: .default),
        lineHeight: 22,
        fontSize: 17
    )
    
    static let title2MediumRounded = TextStyles(
        font: .system(size: 17, weight: .medium, design: .rounded),
        lineHeight: 22,
        fontSize: 17
    )
    
    static let title2EmphasizedRounded = TextStyles(
        font: .system(size: 17, weight: .bold, design: .rounded),
        lineHeight: 22,
        fontSize: 17
    )
    
    // Title 3
    static let title3Regular = TextStyles(
        font: .system(size: 15, weight: .regular, design: .default),
        lineHeight: 20,
        fontSize: 15
    )
    
    static let title3Medium = TextStyles(
        font: .system(size: 15, weight: .medium, design: .default),
        lineHeight: 20,
        fontSize: 15
    )
    
    static let title3MediumRounded = TextStyles(
        font: .system(size: 15, weight: .medium, design: .rounded),
        lineHeight: 20,
        fontSize: 15
    )
    
    static let title3EmphasizedRounded = TextStyles(
        font: .system(size: 15, weight: .bold, design: .rounded),
        lineHeight: 20,
        fontSize: 15
    )
    
    // Body
    static let bodyRegular = TextStyles(
        font: .system(size: 13, weight: .regular, design: .default),
        lineHeight: 16,
        fontSize: 13
    )
    
    static let bodyMedium = TextStyles(
        font: .system(size: 13, weight: .medium, design: .default),
        lineHeight: 16,
        fontSize: 13
    )
    
    static let bodyEmphasized = TextStyles(
        font: .system(size: 13, weight: .bold, design: .default),
        lineHeight: 16,
        fontSize: 13
    )
    
    // Chart Label
    static let chartLabelRegular = TextStyles(
        font: .system(size: 12, weight: .regular, design: .default),
        lineHeight: 15,
        fontSize: 12
    )
    
    static let chartLabelEmphasized = TextStyles(
        font: .system(size: 12, weight: .bold, design: .default),
        lineHeight: 15,
        fontSize: 12
    )
    
    // Caption 1
    static let caption1Regular = TextStyles(
        font: .system(size: 11, weight: .regular, design: .default),
        lineHeight: 14,
        fontSize: 11
    )
    
    static let caption1Emphasized = TextStyles(
        font: .system(size: 11, weight: .bold, design: .default),
        lineHeight: 14,
        fontSize: 11
    )
    
    // Caption 2
    static let caption2Regular = TextStyles(
        font: .system(size: 6, weight: .regular, design: .default),
        lineHeight: 9,
        fontSize: 6
    )
}

// Single modifier to apply styles
extension View {
    func textstyles(_ style: TextStyles) -> some View {
        self
            .font(style.font)
            .lineSpacing(style.lineSpacing)
    }
}
