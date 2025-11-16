import SwiftUI

public struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var selection = SidebarType.dashboard.rawValue
    
    //TODO: - Need to move to specific view
    @State private var isShowingSheet = false
    
    public var body: some View {
        GeometryReader { geometry in
            NavigationSplitView (
                sidebar: {
                    Sidebar(selection: $selection)
                },
                detail: {
                    switch selection {
                    case SidebarType.dashboard.rawValue:
                        DashboardPresentation(modelContext: modelContext)
                    case SidebarType.recents.rawValue:
                        RecentUploadsPresentation(modelContext: modelContext)
                    case SidebarType.mock.rawValue:
                        MockDataView()
                    default:
                        Text("Unknown Section")
                    }
                }
                
            )
            .sheet(isPresented: $isShowingSheet, onDismiss: didDismiss) {
                ReviewFishPresentation(isShowingSheet: $isShowingSheet)
                    .frame(width: geometry.size.width - 100,
                           height: geometry.size.height - 100)
            }
        }
        
    }
    
    //TODO: - Need to move to specific view
    func didDismiss() {
        print("Its Dismissed")
        // Handle the dismissing action.
    }
    
//    func createUploadVideoViewModel() -> UploadVideoViewModel {
//        let dataService = DataService(modelContainer: modelContext.container)
//        let uploadVideoData = UploadVideoData(dataService: dataService)
//        let uploadVideoDomain = UploadVideoDomain(uploadVideoData: uploadVideoData)
//        return UploadVideoViewModel(uploadVideoDomain: uploadVideoDomain)
//    }
    
//    func createUploadCompleteViewModel(for footageUID: UUID) -> UploadCompleteViewModel {
//        let dataService = DataService(modelContainer: modelContext.container)
//        let footageData = FootageData(dataService: dataService)
//        let domain = UploadCompleteDomain(footageData: footageData)
//        return UploadCompleteViewModel(footageUID: footageUID, domain: domain)
//    }
}


#Preview {
    ContentView()
}

