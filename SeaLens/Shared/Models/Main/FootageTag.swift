//
//  Tags.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftData

@Model
final class FootageTag {
    @Attribute(.unique) var uid: UUID
    var name: String
    
    //0..many footageTags belong to one footage
    var footage: Footage
    
    init(
        uid: UUID,
        name: String,
        footage: Footage)
    {
        self.uid = uid
        self.name = name
        self.footage = footage
    }
}

// MARK: - Mock Data
extension FootageTag {
    static func shallowMock(in context: ModelContext, footage: Footage) -> FootageTag {
        let obj = FootageTag(uid: UUID(), name: ["reef","training","deep","nursery","survey"].randomElement()!, footage: footage)
        context.insert(obj)
        return obj
    }

    static func mock(in context: ModelContext, footage: Footage? = nil) -> FootageTag {
        let footage = footage ?? Footage.shallowMock(in: context)
        return shallowMock(in: context, footage: footage)
    }

    static func mockArray(in context: ModelContext, count: Int = Int.random(in: 2...5), footage: Footage? = nil) -> [FootageTag] {
        let footage = footage ?? Footage.shallowMock(in: context)
        return (0..<count).map { _ in shallowMock(in: context, footage: footage) }
    }
}
