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
        
        let sites = Site.mockArray(in: context)
        sites.forEach { context.insert($0) }
        
        let locations = Location.mockArray(in: context)
        locations.forEach { context.insert($0) }
        
        let transects = Transect.mockArray(in: context)
        transects.forEach { context.insert($0) }
        
        let familyRefs = FishFamilyReference.mockArray(in: context, count: 12)
        familyRefs.forEach { context.insert($0) }
        
        let footages = Footage.mockCompleteArray(in: context, masterFamilyRefs: familyRefs)
        footages.forEach { context.insert($0) }
        
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
extension MockDataSeeder {
    static func saveData(footage: Footage, at context: ModelContext) {
        // Get FishFamilyReference
        // in order to use existing value, so that it won't get duplicated
        let familyRefsSortBy = [SortDescriptor(\FishFamilyReference.commonName)]
        let descriptor = FetchDescriptor<FishFamilyReference>(predicate: nil, sortBy: familyRefsSortBy)
        var familyRefs: [FishFamilyReference] = []
        do {
            familyRefs = try context.fetch(descriptor)
        } catch {
            print("Failed to retrieve Fish Family Reference (MockDataSeeder): \(error.localizedDescription)")
        }
        
        let fishFamilies =  (0..<Int.random(in: 1...12)).map { _ in
            FishFamily.shallowMock(in: context, footage: footage, masterFamilyRefs: familyRefs,  attachCompleteRef: true)
        }
        footage.fishFamily = fishFamilies
        
        let tags = (0..<Int.random(in: 3...10)).map { _ in
            FootageTag.shallowMock(in: context, footage: footage)
        }
        
        footage.footageTags = tags
        
        context.insert(footage)
        
        do {
            try context.save()
        } catch {
            #if DEBUG
            print("⚠️ MockDataSeeder: failed to save context: \(error)")
            #endif
        }
    }
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
