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

// MARK: - Transect
extension Transect {
    static func mock(in context: ModelContext, name: String? = nil) -> Transect {
        let obj = Transect(uid: UUID(), name: name ?? "Transect \(Int.random(in: 1...10))")
        context.insert(obj)
        return obj
    }

    static func mockArray(in context: ModelContext, count: Int = Int.random(in: 2...5)) -> [Transect] {
        (0..<count).map { _ in mock(in: context) }
    }
}
