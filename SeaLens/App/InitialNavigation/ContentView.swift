import SwiftUI

public struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    //
    @StateObject private var initialNavigationViewModel = InitialNavigationViewModel()
    @State private var recentPath = NavigationPath()
    
    public var body: some View {
        GeometryReader { geometry in
            NavigationSplitView (
                sidebar: {
                    Sidebar(selection: $initialNavigationViewModel.sidebarSelection)
                },
                detail: {
                    NavigationStack (path: $recentPath) {
                        Group {
                            switch initialNavigationViewModel.sidebarSelection {
                            case SidebarType.dashboard.rawValue:
                                DashboardPresentation(modelContext: modelContext)
                            case SidebarType.recents.rawValue:
                                RecentUploadsPresentation(
                                    initialNavigationViewModel: initialNavigationViewModel)
                            case SidebarType.mock.rawValue:
                                MockDataView()
                            default:
                                Text("Unknown Section")
                            }
                        }
                        .navigationDestination(for: String.self) { uidString in
                            let footageDetailViewModel = FootageDetailViewModel(footageUIDString: uidString)
                            FootageDetailPresentation(
                                viewModel: footageDetailViewModel,
                                initialNavigationViewModel: initialNavigationViewModel
                            )
                        }
                    }
                }
                
            )
            .sheet(isPresented: $initialNavigationViewModel.isShowingUploadFootage, onDismiss: didDismiss) {
                UploadVideoPresentation(initialNavigationViewModel: initialNavigationViewModel)
                    .frame(width: geometry.size.width - 100,
                           height: geometry.size.height - 100)
            }
            .sheet(isPresented: $initialNavigationViewModel.isShowingReviewFish) {
                ReviewFishPresentation(isShowingSheet: $initialNavigationViewModel.isShowingReviewFish)
                    .frame(width: geometry.size.width - 100,
                           height: geometry.size.height - 100)
            }
        }
        .onChange(of: initialNavigationViewModel.newFootageUid) { _, newValue in
            guard let footageUid = newValue else { return }
            Task {
                recentPath.append(footageUid.uuidString)
                await initialNavigationViewModel.resetNewFootageUid()
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

