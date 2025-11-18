import SwiftUI
import SwiftData

@main
struct SeaLensApp: App {
    let container: ModelContainer
        
    init() {
        container = SwiftDataService.shared.container
        let dataService = DataService(modelContainer: container)
        let networkService = NetworkService()
        
        // Datas
        DIContainer.shared.register(FootageData.self) {
            FootageData(dataService: dataService)
        }
        DIContainer.shared.register(FishData.self) {          
            FishData(dataService: dataService)
        }
        DIContainer.shared.register(UploadVideoData.self) {
            UploadVideoData(networkService: networkService, dataService: dataService)
        }
        
        // Domain
        DIContainer.shared.register(UploadVideoDomain.self) {
            UploadVideoDomain()
        }
        DIContainer.shared.register(RecentUploadsDomain.self) {
            RecentUploadsDomain()
        }
        DIContainer.shared.register(FootageDetailDomain.self) {
            FootageDetailDomain()
        }
        DIContainer.shared.register(ImageDetailDomain.self) {
            ImageDetailDomain()
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
