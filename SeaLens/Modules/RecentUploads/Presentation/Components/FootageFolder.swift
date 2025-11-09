//
//  Folder.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftUI

struct Folder<Destination: View>: View {
    var destination: Destination
    
    var title: String
    
    var body: some View {
        NavigationLink(destination: destination) {
            ZStack(alignment: .center) {
                Image("folder")
                    .renderingMode(.original)
                
                VStack(alignment: .leading) {
                    Spacer()
                    Text(title)
                        .textstyles(.title2Regular)
                        .lineLimit(3)
                        .padding()
                }
                .frame(width: 155, height: 160)
            }
            .padding()
            .frame(width: 155, height: 160)
        }
        .buttonStyle(.plain)
    }
}


#Preview {
    Folder(destination: UploadVideoPresentation(), title: "sample test")
}
