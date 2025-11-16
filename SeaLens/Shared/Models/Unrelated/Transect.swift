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

// MARK: - Mock Data
extension Transect {
    static var mockArray: [Transect] {
        (0..<Int.random(in: 3...10)).map { _ in
            Transect(name: "Transect \(Int.random(in: 1...10))")
        }
    }
}
