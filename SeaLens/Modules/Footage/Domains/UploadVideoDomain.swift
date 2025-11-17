//
//  UploadVideoDomain.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 27/10/2025.
//

import Foundation

struct UploadVideoDomain {
    @Injected var uploadVideoData: UploadVideoData
            
    // MARK: - Upload Video
    func uploadVideo(fileURL: URL,
                     progress: @escaping (Double) -> Void,
                     completion: @escaping (Result<String, Error>) -> Void) {
        uploadVideoData.upload(fileURL: fileURL, progress: progress, completion: completion)
    }
}
