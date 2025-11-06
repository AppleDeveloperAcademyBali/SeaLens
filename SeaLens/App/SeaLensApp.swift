import SwiftUI
import SwiftData

@main
struct SeaLensApp: App {

    let container: ModelContainer
    
    init () {
        do {
            let schema = Schema([
                Footage.self,
                FootageTags.self,
                FishFamily.self,
                Fish.self,
                FishConfidenceScore.self,
                FishFamilyReference.self,
                FishSpeciesReference.self,
                Site.self
            ])
            
            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
            
            self.container = try ModelContainer(for: schema, configurations: [config])
        }
        catch {
            print(error)
            fatalError("Failed to initialize ModelContainer \(error)")
        }
    }
    
    var body: some Scene {
        
        
        WindowGroup {
            ContentView()
                .frame(minWidth: 1200, minHeight: 800)
                .modelContext(container.mainContext)
        }
    }
}
