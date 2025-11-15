//
//  FootageTags.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 27/10/25.
//

import Foundation
import SwiftData

@Model
final class FootageTags {
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
