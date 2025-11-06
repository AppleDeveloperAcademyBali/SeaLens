//
//  Folder.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftUI

struct Folder: View {
    var title: String
    
    let onTap: () -> Void
    
    var body: some View {
        
        ZStack(alignment: .center) {
            Image("folder")
            
            VStack(alignment: .leading) {
                Spacer()
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.black)
                    .lineLimit(2)
                    .padding()
            }
            .frame(width: 152, height: 152)
        }
        .onTapGesture(perform: onTap)
        
    }
}


#Preview {
    Folder(title: "Padang Bai Jun_2025", onTap: {})
}
