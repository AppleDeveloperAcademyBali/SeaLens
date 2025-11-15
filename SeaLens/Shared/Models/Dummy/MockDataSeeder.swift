//
//  MockDataSeeder.swift
//  SeaLens
//
//  Created by Handy Handy on 15/11/25.
//

import Foundation
import SwiftData

@MainActor
struct MockDataSeeder {
    
    // MARK: - Public API
    
    /// Seed the given context with mock data.
    /// - Parameters:
    ///   - context: The ModelContext to insert data into.
    ///   - clearExisting: If true, deletes all existing objects before seeding.
    static func seed(_ context: ModelContext, clearExisting: Bool = false) {
        if clearExisting {
            deleteAll(in: context)
        }
        
        // If you don’t want duplicate seeding, early-return when data already exists
        if hasExistingData(in: context) && clearExisting == false {
            return
        }
        
        // Generate and insert mock data.
        // NOTE: We call `.mockArray` exactly once per type here so you get one
        // consistent in-memory graph per seeding run.
        
        let familyRefs = FishFamilyReference.mockArray
        familyRefs.forEach { context.insert($0) }
        
        let speciesRefs = FishSpeciesReference.mockArray
        speciesRefs.forEach { context.insert($0) }
        
        let locations = Location.mockArray
        locations.forEach { context.insert($0) }
        
        let sites = Site.mockArray
        sites.forEach { context.insert($0) }
        
        let transects = Transect.mockArray
        transects.forEach { context.insert($0) }
        
        let footages = Footage.mockArray
        footages.forEach { context.insert($0) }
        
        let fishFamilies = FishFamily.mockArray
        fishFamilies.forEach { context.insert($0) }
        
        let fishes = Fish.mockArray
        fishes.forEach { context.insert($0) }
        
        let fishImages = FishImage.mockArray
        fishImages.forEach { context.insert($0) }
        
        let scores = FishConfidenceScore.mockArray
        scores.forEach { context.insert($0) }
        
        let masterTags = FootageTag.mockArray
        masterTags.forEach { context.insert($0) }
        
        do {
            try context.save()
        } catch {
            #if DEBUG
            print("⚠️ MockDataSeeder: failed to save context: \(error)")
            #endif
        }
    }
    
    static func deleteAllData(in context: ModelContext) {
        deleteAll(in: context)
    }
    
    /// Seed only if there is no data yet (useful for app start / previews).
    static func seedIfEmpty(_ context: ModelContext) {
        if hasExistingData(in: context) == false {
            seed(context, clearExisting: false)
        }
    }
    
    // MARK: - Preview Convenience
    
    /// In-memory container with seeded mock data, perfect for SwiftUI previews.
    static var previewContainer: ModelContainer = {
        let schema = Schema([
            FishFamilyReference.self,
            FishSpeciesReference.self,
            Footage.self,
            FishFamily.self,
            Fish.self,
            FishImage.self,
            FishConfidenceScore.self,
            FootageTag.self,
            Location.self,
            Site.self,
            Transect.self
        ])
        
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        
        let container: ModelContainer
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("⚠️ Failed to create in-memory ModelContainer for previews: \(error)")
        }
        
        MockDataSeeder.seed(container.mainContext, clearExisting: true)
        return container
    }()
}

@MainActor
private extension MockDataSeeder {
    
    /// Quick heuristic: if there is at least one Footage, we assume DB is seeded.
    static func hasExistingData(in context: ModelContext) -> Bool {
        var descriptor = FetchDescriptor<Footage>()
        descriptor.fetchLimit = 1
        
        if let items = try? context.fetch(descriptor) {
            return items.isEmpty == false
        }
        return false
    }
    
    static func deleteAll(in context: ModelContext) {
        deleteAll(of: FishConfidenceScore.self, in: context)
        deleteAll(of: FishImage.self, in: context)
        deleteAll(of: Fish.self, in: context)
        deleteAll(of: FishFamily.self, in: context)
        deleteAll(of: FootageTag.self, in: context)
        deleteAll(of: Footage.self, in: context)
        deleteAll(of: FishSpeciesReference.self, in: context)
        deleteAll(of: FishFamilyReference.self, in: context)
        deleteAll(of: Location.self, in: context)
        deleteAll(of: Site.self, in: context)
        deleteAll(of: Transect.self, in: context)
        
        do {
            try context.save()
        } catch {
            #if DEBUG
            print("⚠️ MockDataSeeder: failed to save after deleteAll: \(error)")
            #endif
        }
    }
    
    static func deleteAll<T: PersistentModel>(of type: T.Type, in context: ModelContext) {
        let descriptor = FetchDescriptor<T>()
        do {
            let objects = try context.fetch(descriptor)
            objects.forEach { context.delete($0) }
        } catch {
            #if DEBUG
            print("⚠️ MockDataSeeder: failed to delete \(T.self): \(error)")
            #endif
        }
    }
}

/*
 Use it in preview:
 
 struct SomeView_Previews: PreviewProvider {
     static var previews: some View {
         SomeView()
             .modelContainer(MockDataSeeder.previewContainer)
     }
 }
 */
