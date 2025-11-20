import SwiftUI

public struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var router: NavigationRouter
    //
    @State private var recentPath = NavigationPath()
    
    public var body: some View {
        GeometryReader { geometry in
            NavigationSplitView (
                sidebar: {
                    Sidebar(selection: $router.sidebarSelection)
                },
                detail: {
                    NavigationStack (path: $recentPath) {
                        Group {
                            switch router.sidebarSelection {
                            case SidebarType.dashboard.rawValue:
                                DashboardPresentation(modelContext: modelContext)
                            case SidebarType.recents.rawValue:
                                RecentUploadsPresentation()
                            case SidebarType.mock.rawValue:
                                MockDataView()
                            case SidebarType.testImageDetail.rawValue:
                                TestImageDetailLoaderView()
                            default:
                                Text("Unknown Section")
                            }
                        }
                        .navigationDestination(for: String.self) { uidString in
                            let footageDetailViewModel = FootageDetailViewModel(footageUIDString: uidString)
                            FootageDetailPresentation(
                                viewModel: footageDetailViewModel
                            )
                        }
                    }
                }
                
            )
            .sheet(isPresented: $router.isShowingUploadFootage, onDismiss: didDismiss) {
                UploadVideoPresentation()
                    .frame(width: geometry.size.width - 100,
                           height: geometry.size.height - 100)
            }
            .sheet(isPresented: $router.isShowingReviewFish) {
                ReviewFishPresentation(
                    footageUidString: "TODO: Replace with actual UID",
                    isShowingSheet: $router.isShowingReviewFish)
                    .frame(width: geometry.size.width - 100,
                           height: geometry.size.height - 100)
            }
        }
        .onChange(of: router.newFootageUid) { _, newValue in
            guard let footageUid = newValue else { return }
            Task {
                recentPath.append(footageUid.uuidString)
                await router.resetNewFootageUid()
            }
            
        }
    }
    
    //TODO: - Need to move to specific view
    func didDismiss() {
        print("Its Dismissed")
        // Handle the dismissing action.
    }
    
}


#Preview {
    ContentView()
}

