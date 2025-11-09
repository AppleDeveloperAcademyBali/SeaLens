import SwiftUI

public struct ContentView: View {
    //TODO: - Need to move to specific view
    @State private var isShowingSheet = false
    @State private var windowSize: CGSize = .zero
    
    @Environment(\.modelContext) var modelContext
    @State private var selection = "Dashboard"
    
    public var body: some View {
        GeometryReader { geometry in
            NavigationSplitView (
                sidebar: {
                    Sidebar(selection: $selection) {
                        isShowingSheet.toggle()
                    }
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
            .background(WindowSizeReader(size: $windowSize))
            .sheet(isPresented: $isShowingSheet, onDismiss: didDismiss) {
                ReviewFishPresentation(isShowingSheet: $isShowingSheet)
                    .frame(width: geometry.size.width - 100, height: geometry.size.height - 100)
            }
        }
        
    }
    
    //TODO: - Need to move to specific view
    func didDismiss() {
        // Handle the dismissing action.
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

