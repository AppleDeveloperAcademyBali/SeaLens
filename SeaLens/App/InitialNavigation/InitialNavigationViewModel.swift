//
//  InitialNavigationViewModel.swift
//  SeaLens
//
//  Created by Handy Handy on 16/11/25.
//

import Foundation

@MainActor
class InitialNavigationViewModel: ObservableObject {

    @Published var isShowingUploadFootage = false
    
    func dismissUploadFootage() {
        isShowingUploadFootage = false
    }
    
    func showingUploadFootage() {
        isShowingUploadFootage = true
    }
}
