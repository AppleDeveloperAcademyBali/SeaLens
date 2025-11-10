import SwiftUI

public struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var selection = "Dashboard"
    
    @ObservedObject var viewModel: UploadVideoViewModel


    
    public var body: some View {
        
        NavigationSplitView (
            sidebar: {
                Sidebar(selection: $selection)
            },
            detail: {
                switch selection {
                case "Dashboard":
                    UploadVideoPresentation()
                case "Recent Uploads":
                    RecentUploadsPresentation(modelContext: modelContext)
                case "Fish Collection":
                    UploadCompletePresentation(viewModel: viewModel)
                default:
                    Text("Unknown Section")
                }
            }
            
        )
    }
}


#Preview {
    ContentView(viewModel: UploadVideoViewModel())
}

