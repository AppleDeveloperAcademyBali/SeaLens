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
                    UploadVideoPresentation(viewModel: createUploadVideoViewModel())
                case "Recent Uploads":
                    RecentUploadsPresentation(modelContext: modelContext)
                case "Fish Collection":
                    FishCollectionView()
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

