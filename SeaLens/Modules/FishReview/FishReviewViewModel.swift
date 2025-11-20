//
//  FishReviewViewModel.swift
//  SeaLens
//
//  Created by Handy Handy on 20/11/25.
//

import Foundation

@MainActor
final class FishReviewViewModel: ObservableObject {
    @Injected private var domain: FishReviewDomain
    
    @Published var fishFamilies: [FishFamily] = []
    @Published var footageUid = UUID()
    
    func assignFootageUid(_ uid: UUID) async {
        self.footageUid = uid
    }
    
    func getFishFamilies() async {
        self.fishFamilies = await self.domain.getFishFamilies(by: footageUid)
    }
    
    func updateFishFamilies(_ fishFamily: FishFamily) async {
        _ = await domain.updateFishFamily(fishFamily)
    }
}
