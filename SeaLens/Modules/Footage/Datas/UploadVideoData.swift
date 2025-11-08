//
//  UploadVideoData.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 27/10/2025.
//

import Foundation

struct UploadVideoData {
    
    let networkService: NetworkService

    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func upload(fileURL: URL,
                progress: @escaping (Double) -> Void,
                completion: @escaping (Result<String, Error>) -> Void) {
        networkService.uploadVideo(fileURL: fileURL, progress: progress, completion: completion)
    }
    
}
