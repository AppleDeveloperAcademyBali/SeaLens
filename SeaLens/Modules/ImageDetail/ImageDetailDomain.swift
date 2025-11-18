//
//  ImageDetailDomain.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 16/11/2025.
//

import Foundation

class ImageDetailDomain {
    
    @Injected private var fishData: FishData
    
    // production init (dependency injection)
    init() { }
    
    
    // fetch FishImage by UID
    func getFishImage(by uid: UUID) async -> FishImage? {
        let predicate = #Predicate<FishImage> { $0.uid == uid }

        // perform fetch
        await fishData.retrieveFishes(predicate: predicate, sortBy: nil)

        // return the first matched image
        return fishData.fishes.first
    }
}
