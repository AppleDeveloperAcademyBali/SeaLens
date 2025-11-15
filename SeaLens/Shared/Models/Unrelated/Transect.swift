//
//  Transect.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 06/11/25.
//

import Foundation
import SwiftData

@Model
final class Transect {
    @Attribute(.unique) var uid: UUID
    var name: String
    
    init(
        uid: UUID = .init(),
        name: String)
    {
        self.uid = uid
        self.name = name
    }
}
