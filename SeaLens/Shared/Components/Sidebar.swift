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
    
    //TODO: - Need to move to specific view
    @MainActor var onClick: () -> Void
    
    // list of sidebar items
    private let items: [(title: String, icon: String)] = [
        ("Dashboard", "chart.xyaxis.line"),
        ("Recent Observations", "clock"),
        ("Fish Collection", "rectangle.grid.3x1"),
        ("Upload Video", "tray.and.arrow.up.fill")

    ]
    
    var body: some View {
        
        // list with selection binding to highlight the active item
        List(selection: $selection) {
            
            // loops through each sidebar item and creates a label view
            ForEach(items, id: \.title) { item in
                Label(item.title, systemImage: item.icon)
                    .tag(item.title)
            }
            
            //TODO: - Need to move to specific view
            Button("Review fish count") {
                onClick()
            }
            .buttonStyle(.glass)
            
        }
        // macOS sidebar list appearance (collapsible & transparent)
        .listStyle(SidebarListStyle())
        
        // sets sidebar minimum width
        .frame(minWidth: 200)
    }
    
}

#Preview {
    Sidebar(selection: .constant("Dashboard")) {
        print("Clicked!")
    }
}
