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
    }
    
    func loadFootage() {
        Task {
            if let uid = UUID(uuidString: footageUIDString),
                let fetchedFootage = await domain.getFootage(by: uid)   {
                self.footage = fetchedFootage
                self.fishFamilies = fetchedFootage.fishFamily
            } else {
                self.footage = .shallowMock()
                self.fishFamilies = []
            }
        }
    }
    
    func loadFishFamilies() {
        Task {
            guard let uid = UUID(uuidString: footageUIDString),
               let fetchedFishFamilies = await domain.getFootage(by: uid)?.fishFamily
            else { return }
            self.fishFamilies = fetchedFishFamilies
        }
    }
    
    func getTitle() -> String {
        guard
            let dateTaken = footage?.dateTaken,
            let location = footage?.locationName
        else { return "" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let formattedDate = formatter.string(from: dateTaken)
        return "\(location) - \(formattedDate)"
    }
    
}
