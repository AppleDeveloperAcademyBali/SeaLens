//
//  Folder.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftUI

struct FootageFolder: View {
    
    @State var isHovered: Bool = false
    
    var title: String
    
    var body: some View {
        ZStack {
            FolderComponent()
                .frame(width: 250, height: 150)
            
            VStack {
                Spacer()
                Text(title)
                    .textstyles(.title2Regular)
                    .lineLimit(2)
                    .padding()
            }
            .frame(width: 250, height: 150, alignment: .leading)
            .padding()
        }
        .padding()
        .frame(width: 250, height: 150)
        .onHover { isHovered in
            self.isHovered = isHovered
        }
        .scaleEffect(self.isHovered ? 1.05 : 1, anchor: .center)
    }
}
