import SwiftUI
import SwiftData

@main
struct SeaLensApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 1200, minHeight: 800)
                .modelContainer(SwiftDataService.shared.container)
        }
    }
}
