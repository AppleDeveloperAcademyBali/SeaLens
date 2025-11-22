//
//  UploadCompleteDomain.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 10/11/2025.
//

import Foundation

final class FootageDetailDomain {
    @Injected private var footageData: FootageData

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

    func getTotalFish(by footageUid: UUID) async -> Int {
        let footage = await getFootage(by: footageUid)
        guard let footage else { return 0 }
        let numOfFishDetected = footage.fishFamily.compactMap(\.numOfFishDetected)
        let totalFish = numOfFishDetected.reduce(0, +)
        return Int(totalFish)
    }
    
    func getTotalPhotos(by footageUid: UUID) async -> Int {
        let footage = await getFootage(by: footageUid)
        guard let footage else { return 0 }
        let arrayOfFishes = footage.fishFamily.compactMap(\.fishes)
        let totalPhotos = arrayOfFishes
            .flatMap { $0 }            // flatten [[Fish]] → [Fish]
            .flatMap { $0.fishImages } // flatten all fishImages → [FishImage]
            .count
        return totalPhotos
    }
    
}
