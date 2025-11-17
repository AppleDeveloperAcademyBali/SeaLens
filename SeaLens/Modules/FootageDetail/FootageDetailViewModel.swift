//
//  UploadCompleteViewModel.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 10/11/2025.
//

import Foundation
import SwiftUI
import SwiftData


@MainActor
final class FootageDetailViewModel: ObservableObject {
    @Injected private var domain: FootageDetailDomain
    //
    @Published var footageUIDString: String = ""
    //
    @Published var footage: Footage?
    @Published var fishFamilies: [FishFamily] = []
    
    init(footageUIDString: String) {
        self.footageUIDString = footageUIDString
        self.loadFootage()
    }
    
    func loadFootage() {
        Task {
            if let uid = UUID(uuidString: footageUIDString),
                let fetchedFootage = await domain.getFootage(by: uid)   {
                self.footage = fetchedFootage
                self.fishFamilies = fetchedFootage.fishFamily
            } else {
                self.footage = nil
                self.fishFamilies = []
            }
        }
    }
}
