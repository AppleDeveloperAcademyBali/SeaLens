import SwiftUI

public struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var selection = SidebarType.recents.rawValue
    
    //TODO: - Need to move to specific view
    @State private var isShowingUploadFootage = false
    
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
                        RecentUploadsPresentation(modelContext: modelContext,
                                                  isUploadFormPresented: $isShowingUploadFootage)
                    case SidebarType.mock.rawValue:
                        MockDataView()
                    default:
                        Text("Unknown Section")
                    }
                }
                
            )
            .sheet(isPresented: $isShowingUploadFootage, onDismiss: didDismiss) {
                UploadVideoPresentation(modelContext: modelContext, isPresented: $isShowingUploadFootage)
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

