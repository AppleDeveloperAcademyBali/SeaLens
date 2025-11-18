//
//  RecentUploadDomain.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 07/11/25.
//

import Foundation
import SwiftData

class RecentUploadsDomain {
    @Injected private var footageData: FootageData
    
    func retrieveFootages() async -> [Footage] {
        await footageData.retrieveFootages()
        return footageData.footages
    }
    
}
