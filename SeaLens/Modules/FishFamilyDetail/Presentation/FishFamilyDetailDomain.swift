//
//  FishFamilyDetailDomain.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 14/11/2025.
//

import Foundation
import SwiftData

final class FishFamilyDetailDomain {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchFishFamily(by id: UUID) async -> FishFamily? {
        let predicate = #Predicate<FishFamily> { $0.uid == id }
        let fetch = FetchDescriptor<FishFamily>(predicate: predicate)
        
        do {
            let result = try modelContext.fetch(fetch)
            return result.first
        } catch {
            print("Failed to fetch FishFamily: \(error)")
            return nil
        }
    }
}
