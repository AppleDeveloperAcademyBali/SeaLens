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
    @Published var _sidebarSelection = SidebarType.recents.rawValue
    @Published var newFootageUid: UUID? = nil
    @Published var isShowingReviewFish = false

    var sidebarSelection: String {
            get { _sidebarSelection }
            set {
                DispatchQueue.main.async {
                    self._sidebarSelection = newValue
                }
            }
        }
    
    func dismissUploadFootage() {
        isShowingUploadFootage = false
    }
    
    func showingUploadFootage() {
        isShowingUploadFootage = true
    }
    
    func submittedFootage(uid: UUID) {
        //TODO: - Do Something
        sidebarSelection = SidebarType.recents.rawValue
        newFootageUid = uid
        //
        dismissUploadFootage()
    }
    
    func resetNewFootageUid() async {
        newFootageUid = nil
    }
    
    func dismissReviewFish() {
        isShowingReviewFish = false
    }
    
    func showingReviewFish() {
        isShowingReviewFish = true
    }
}
