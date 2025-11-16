import SwiftUI

public struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    //
    @StateObject private var initialNavigationViewModel = InitialNavigationViewModel()
    //
    @State private var sidebarSelection = SidebarType.recents.rawValue
    
    public var body: some View {
        GeometryReader { geometry in
            NavigationSplitView (
                sidebar: {
                    Sidebar(selection: $sidebarSelection)
                },
                detail: {
                    switch sidebarSelection {
                    case SidebarType.dashboard.rawValue:
                        DashboardPresentation(modelContext: modelContext)
                    case SidebarType.recents.rawValue:
                        RecentUploadsPresentation()
                    case SidebarType.mock.rawValue:
                        MockDataView()
                    default:
                        Text("Unknown Section")
                    }
                }
                
            )
            .sheet(isPresented: $initialNavigationViewModel.isShowingUploadFootage, onDismiss: didDismiss) {
                UploadVideoPresentation(modelContext: modelContext, isPresented: $initialNavigationViewModel.isShowingUploadFootage)
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

