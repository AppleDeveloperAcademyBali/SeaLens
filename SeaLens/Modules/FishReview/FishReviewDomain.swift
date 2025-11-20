//
//  ReviewFishDomain.swift
//  SeaLens
//
//  Created by Handy Handy on 20/11/25.
//

import Foundation

final class FishReviewDomain {
    @Injected private var footageData: FootageData
    @Injected private var fishFamilyData: FishFamilyData

    func getFootage(by uid: UUID) async -> Footage? {
        let predicate = #Predicate<Footage> { $0.uid == uid }
        let sortDescriptors = [SortDescriptor(\Footage.dateCreated, order: .reverse)]
        
        let result = await footageData.retrieveFootages(predicate: predicate, sortBy: sortDescriptors)
        switch result {
        case .success(let footages): return footages.first
        case .failure(let error):
            print("Error retrieving footage: \(error)")
            return nil
        }
    }
    
    func getFishFamilies(by footageUid: UUID) async -> [FishFamily] {
        let footage = await getFootage(by: footageUid)
        guard let footage else { return [] }
        return footage.fishFamily
    }

    func updateFishFamily(_ fishFamily: FishFamily) async {
        await fishFamilyData.updateFishFamily(fishFamily)
    }
}
