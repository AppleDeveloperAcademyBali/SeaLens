import SwiftUI
import SwiftData

@main
struct SeaLensApp: App {
    let container: ModelContainer
        
    init() {
        container = SwiftDataService.shared.container
        let dataService = DataService(modelContainer: container)
        
        // Datas
        DIContainer.shared.register(FootageData.self) {
            FootageData(dataService: dataService)
        }
        
        // Domain
        DIContainer.shared.register(RecentUploadsDomain.self) {
            RecentUploadsDomain()
        }
        DIContainer.shared.register(FootageDetailDomain.self) {
            FootageDetailDomain()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 1200, minHeight: 800)
                .modelContainer(container)
        }
    }
}
