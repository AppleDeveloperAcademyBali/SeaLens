import SwiftUI

public struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var selection = "Dashboard"
    
    public var body: some View {
        
        NavigationSplitView (
            sidebar: {
                Sidebar(selection: $selection)
            },
            detail: {
                switch selection {
                case "Dashboard":
                    DashboardPresentation(modelContext: modelContext)
                case "Recent Observations":
                    RecentUploadsPresentation(modelContext: modelContext)
                case "Fish Collection":
                    UploadVideoPresentation(viewModel: createUploadVideoViewModel())
                    //FishCollectionView()
                default:
                    Text("Unknown Section")
                }
            }
            
        )
    }
    
    func createUploadVideoViewModel() -> UploadVideoViewModel {
        let dataService = DataService(modelContainer: modelContext.container)
        let uploadVideoData = UploadVideoData(dataService: dataService)
        let uploadVideoDomain = UploadVideoDomain(uploadVideoData: uploadVideoData)
        return UploadVideoViewModel(uploadVideoDomain: uploadVideoDomain)
    }
}


#Preview {
    ContentView()
}

