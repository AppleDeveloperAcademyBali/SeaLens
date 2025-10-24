//
//  Sidebar.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 24/10/2025.
//

import SwiftUI

struct Sidebar: View {
    
    @Binding var selection: String
    
    
    private let items: [(title: String, icon: String)] = [
        ("Dashboard", "chart.xyaxis.line"),
        ("Recent Uploads", "clock"),
        ("Fish Collection", "rectangle.grid.3x1")
    ]
    
    var body: some View {
        List(selection: $selection) {
            ForEach(items, id: \.title) { item in
                Label(item.title, systemImage: item.icon)
                    .tag(item.title)
            }
            
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 100)
    }
    
}

#Preview {
    Sidebar(selection: .constant("Dashboard"))
}
