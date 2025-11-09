//
//  UploadVideoDomain.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 27/10/2025.
//

import Foundation

struct UploadVideoDomain {
    
    let uploadVideoData: UploadVideoData
    
    init(uploadVideoData: UploadVideoData) {
        self.uploadVideoData = uploadVideoData
    }
        
    // MARK: - Upload Video
    func uploadVideo(fileURL: URL,
                     progress: @escaping (Double) -> Void,
                     completion: @escaping (Result<String, Error>) -> Void) {
        uploadVideoData.upload(fileURL: fileURL, progress: progress, completion: completion)
    }
}
