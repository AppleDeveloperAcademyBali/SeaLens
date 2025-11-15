//
//  FishFamilyViewModel.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 14/11/2025.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
final class FishFamilyDetailViewModel: ObservableObject {
    
    @Published var fishFamily: FishFamily?
    @Published var isLoading = true
    
    var domain: FishFamilyDetailDomain?
    private let fishFamilyID: UUID
    
    init(fishFamilyID: UUID, domain: FishFamilyDetailDomain?) {
        self.fishFamilyID = fishFamilyID
        self.domain = domain
    }
    
    func load() {
        
        guard let domain else {
            print("FishFamilyDetailDomain not set")
            return
        }
        
        Task { @MainActor in
            isLoading = true
            defer { isLoading = false }
            self.fishFamily = await domain.fetchFishFamily(by: fishFamilyID)
        }
    }
}
