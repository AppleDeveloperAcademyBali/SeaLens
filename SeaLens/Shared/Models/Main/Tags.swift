//
//  Tags.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftData

@Model
final class Tags {
    @Attribute(.unique) var uid: UUID
    var name: String
    
    init(
        uid: UUID,
        name: String)
    {
        self.uid = uid
        self.name = name
    }
}
