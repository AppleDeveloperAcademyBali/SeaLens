//
//  Folder.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftUI

struct FootageFolder: View {
    
    var title: String
    
    var body: some View {
        ZStack {
            Image("observationCard")
                .renderingMode(.original)
            
            VStack {
                Spacer()
                Text(title)
                    .textstyles(.title2Regular)
                    .lineLimit(2)
                    .padding()
            }
            .frame(width: 285, height: 155, alignment: .leading)
        }
        .padding()
        .frame(width: 285, height: 155)
    }
}
