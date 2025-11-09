//
//  UploadVideoData.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 27/10/2025.
//

import Foundation

struct UploadVideoData {
    
    let networkService: NetworkService
    let dataService: DataService

    init(
        networkService: NetworkService = NetworkService(),
        dataService: DataService
    ) {
        self.networkService = networkService
        self.dataService = dataService
    }
    
    func upload(fileURL: URL,
                progress: @escaping (Double) -> Void,
                completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.global().async {
            self.networkService.uploadVideo(fileURL: fileURL, progress: progress, completion: completion)
        }
    }
    
}
