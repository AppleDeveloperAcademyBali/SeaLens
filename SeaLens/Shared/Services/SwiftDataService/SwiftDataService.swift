//
//  SwiftDataService.swift
//  SeaLens
//
//  Created by Handy Handy on 08/11/25.
//

import Foundation
import SwiftData

public final class SwiftDataService {
    
    let container: ModelContainer
    
    static let shared = SwiftDataService()

    private init () {
        do {
            let schema = Schema([
                Footage.self,
                FootageTags.self,
                FishFamily.self,
                Fish.self,
                FishConfidenceScore.self,
                FishFamilyReference.self,
                FishSpeciesReference.self,
                IndividualFish.self,
                Site.self,
                Location.self,
                Transect.self
            ])
            
            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            self.container = try ModelContainer(for: schema, configurations: [config])
        }
        catch {
            print(error)
            fatalError("Failed to initialize ModelContainer \(error)")
        }
    }
    
}
