//
//  RecentUploadsPersistenceProtocol.swift
//  SeaLens
//
//  Created by IP Marry Kusuma on 28/10/25.
//

import Foundation

protocol RecentUploadsPersistenceProtocol {
    func fetchAllRecentUploads() throws -> [Footage]
}
