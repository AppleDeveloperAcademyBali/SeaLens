//
//  Sidebar.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 24/10/2025.
//

import SwiftUI

struct Sidebar: View {
    
    // a binding to track which sidebar item is currently selected
    @Binding var selection: String
    
    // list of sidebar items
    private let items: [(title: String, icon: String)] = [
        (SidebarType.dashboard.rawValue, "chart.xyaxis.line"),
        (SidebarType.recents.rawValue, "clock"),

    ]
    
    // development pages
    private let devPages: [(title: String, icon: String)] = [
        (SidebarType.mock.rawValue, "gear"),

    ]
    
    var body: some View {
        
        // list with selection binding to highlight the active item
        List(selection: $selection) {
            
            // loops through each sidebar item and creates a label view
            ForEach(items, id: \.title) { item in
                Label(item.title, systemImage: item.icon)
                    .tag(item.title)
            }
            
            #if DEBUG
            Section {
                Text("Development")
            }
            
            ForEach(devPages, id: \.title) { devItem in
                Label(devItem.title, systemImage: devItem.icon)
                    .tag(devItem.title)
            }
            #endif
            
        }
        // macOS sidebar list appearance (collapsible & transparent)
        .listStyle(SidebarListStyle())
        
        // sets sidebar minimum width
        .frame(minWidth: 200)
    }
    
}

#Preview {
    Sidebar(selection: .constant("Dashboard"))
}
