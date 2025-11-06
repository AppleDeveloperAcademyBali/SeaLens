import SwiftUI
import SwiftData

@main
struct SeaLensApp: App {
<<<<<<< HEAD
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
    
=======

>>>>>>> main
    var body: some Scene {
        
        
        WindowGroup {
            ContentView()
<<<<<<< HEAD
                .frame(minWidth: 1200, minHeight: 700)
                .modelContext(container.mainContext)
=======
                .frame(minWidth: 1400, minHeight: 800)
>>>>>>> main
        }
    }
}
