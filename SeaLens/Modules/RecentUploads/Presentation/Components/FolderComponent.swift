//
//  FolderComponent.swift
//  SeaLens
//
//  Created by Handy Handy on 17/11/25.
//

import SwiftUI

import SwiftUI

struct FolderComponent: View {
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            let widthRatio = 200.0
            let heightRatio = 160.0
            // base sizes as proportions (taken from your 300x200 layout)
            let whiteWidthRatio: CGFloat   = 170 / widthRatio
            let whiteHeightRatio: CGFloat  = 100 / heightRatio
            let capsuleWidthRatio: CGFloat = 190 / widthRatio
            let capsuleHeightRatio: CGFloat = 80 / heightRatio
            let frontWidthRatio: CGFloat   = 200 / widthRatio

            let offsetBack0Ratio: CGFloat  = 55 / heightRatio
            let offsetBack1Ratio: CGFloat  = 40 / heightRatio
            let offsetBackZRatio: CGFloat  = 27 / heightRatio
            let offsetBack2Ratio: CGFloat  = 25 / heightRatio
            let offsetCapsuleRatio: CGFloat = 20 / heightRatio

            let cornerRadiusRatio: CGFloat = 16 / 200
            let capsuleRadiusRatio: CGFloat = 50 / 200

            ZStack {
                Rectangle()
                    .frame(width: w * frontWidthRatio,
                           height: h * whiteHeightRatio)
                    .roundedCorners(radius: h * cornerRadiusRatio,
                                    corners: [.topLeft, .topRight])
                    .offset(y: -h * offsetBack0Ratio)
                    .glassEffect(.identity)
                // back white 1
                Rectangle()
                    .foregroundColor(Color("folder-white"))
                    .frame(width: w * whiteWidthRatio,
                           height: h * whiteHeightRatio)
                    .roundedCorners(radius: h * cornerRadiusRatio,
                                    corners: [.topLeft, .topRight])
                    .offset(y: -h * offsetBack1Ratio)
                    .shadow(radius: h * 0.05)

                // back white 2
                Rectangle()
                    .foregroundColor(Color("folder-white"))
                    .frame(width: w * whiteWidthRatio,
                           height: h * whiteHeightRatio)
                    .roundedCorners(radius: h * cornerRadiusRatio,
                                    corners: [.topLeft, .topRight])
                    .offset(y: -h * offsetBack2Ratio)
                    .shadow(radius: h * 0.05)

                // blue capsule (top part of folder)
                Capsule()
                    .foregroundColor(Color("folder-blue"))
                    .frame(width: w * capsuleWidthRatio,
                           height: h * capsuleHeightRatio)
                    .roundedCorners(radius: h * capsuleRadiusRatio,
                                    corners: [.topLeft, .topRight])
                    .offset(y: -h * offsetCapsuleRatio)
                    .shadow(radius: h * 0.05)

                // blue bottom rectangle
                Rectangle()
                    .foregroundColor(Color("folder-blue"))
                    .frame(width: w * frontWidthRatio,
                           height: h * whiteHeightRatio)
                    .roundedCorners(radius: h * cornerRadiusRatio,
                                    corners: [.bottomLeft, .bottomRight])
                    
            }
            .frame(width: w, height: h)
            .offset(y: h * offsetBackZRatio)
        }
    }
}

#Preview {
    FolderComponent()
        .frame(width: 300, height: 200)
        .background(Color.blue.opacity(0.1)) // change this to anything, it scales
        .padding()
        .background(Color.red.opacity(0.1))
}

