import SwiftUI

public struct ContentView: View {
    
    @State private var selection = "Dashboard"
    
    public var body: some View {
        
        NavigationSplitView (
            sidebar: {
                Sidebar(selection: $selection)
            },
            detail: {
                switch selection {
                case "Dashboard":
                    DashboardView()
                case "Recent Uploads":
                    RecentUploadsView()
                case "Fish Collection":
                    FishCollectionView()
                default:
                    Text("Unknown Section")
                }
            }
            
        )
    }
}


#Preview {
    ContentView()
}

