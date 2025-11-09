//
//  NetworkService.swift
//  SeaLens
//
//  Created by Shreyas Venadan on 20/10/2025.
//

import Foundation


// MARK: - Custom Errors
enum NetworkServiceError: Error {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case noData
    case decodingFailed
    case uploadingFailed(String)
    case downloadFailed(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .httpError(statusCode: let statusCode):
            return "HTTP Error with status code: \(statusCode)"
        case .noData:
            return "No data received from the server"
        case .decodingFailed:
            return "Failed to decode response"
        case .uploadingFailed(let message):
            return "Upload failed: \(message)"
        case .downloadFailed(let message):
            return "Download failed: \(message)"
        }
    }
}


// MARK: - NetwrokService Class
class NetworkService: NetworkServiceProtocol    {
    
    // server URL
    private let serverURL = "https://ideal-rare-crayfish.ngrok-free.app"
    private let session: URLSession
    
    // allow injection of custom URLSession for testing
    init(session: URLSession = .shared) {
        self.session = session
    }

    
    // MARK: - Server Health Check
    func checkServerHealth() async throws -> String {
        
        // convert serverURL(String) to a URL
        guard let baseURL = URL(string: serverURL) else {
            throw NetworkServiceError.invalidURL
        }
        
        // construct the full endpoint by adding "/"
        let endpoint = baseURL.appendingPathComponent("/")
        
        // create and configure the url request
        var request = URLRequest(url: endpoint)
        
        // set HTTP method to GET to retreive the data
        request.httpMethod = "GET"
        
        // ngrok shows a warning in browsers, this header skips it for API calls
        request.setValue("true", forHTTPHeaderField: "ngrok-skip-browser-warning")
        
        // timeout 10 seconds
        request.timeoutInterval = 10
        
        // make network request
        let (data, response) = try await session.data(for: request)
        
        // cast response to access status code
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkServiceError.invalidResponse
        }
        
        // verify status code in range (200-299)
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkServiceError.httpError(statusCode: httpResponse.statusCode)
        }
        
        // convets binary data to a foundation object
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        
        //  extract the "status" string from the JSON dictionary
        guard let json = jsonObject as? [String: Any],
              let message = json["status"] as? String else {
            throw NetworkServiceError.decodingFailed
        }
        
            
       return message
        
    }
    
    
    // MARK: - Upload Video
    func uploadVideo(
        fileURL: URL,                                                       // local path of the video to upload
        progress: @escaping (Double) -> Void,                               // closure to report upload progress
        completion: @escaping (Result<String, Error>) -> Void               // closeure to report success or failure
    ){
        
        // construct the full API endpoint for uploading videos
        guard let uploadURL = URL(string: "\(serverURL)/upload") else {
            completion(.failure(NetworkServiceError.invalidURL))
            return
        }
        
        // create a POST request to send data to the server
        var request = URLRequest(url: uploadURL)
        request.httpMethod = "POST"
        
        // generate a random boundary string
        let boundary = UUID().uuidString
        
        // set the content-type header to indicate multipart upload
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // build multipart/form-data request body
        var body = Data()
        let fileName = fileURL.lastPathComponent
        let mimeType = "video/mp4"
        
        
        // start the first boundary line
        body.append("--\(boundary)\r\n".data(using: .utf8)!)

        // tell the server this is a file field, with its name and filename
        body.append("Content-Disposition: form-data; name=\"video\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)

        // tell the server the file type
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        
        // read the file's binary data and append it to the body
        body.append((try? Data(contentsOf: fileURL)) ?? Data())
        
        // add a newline after the file data
        body.append("\r\n".data(using: .utf8)!)
        
        // mark the end of the multipart form data
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        
        // create the upload task
        let task = session.uploadTask(with: request, from: body) { data, response, error in
            
            // handle network erros
            if let error = error {
                completion(.failure(NetworkServiceError.uploadingFailed(error.localizedDescription)))
                return
            }
            
            // ensure valid HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkServiceError.invalidResponse))
                return
            }

            // check if status code is within the success range
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkServiceError.httpError(statusCode: httpResponse.statusCode)))
                return
            }
            
            // completion message
            completion(.success("Upload successful"))
            
            
        }
        
        // observe the progress of the upload and call the progress closure with a fraction (0.0–1.0)
        let _ = task.progress.observe(\.fractionCompleted)    { progressObj, _ in
            progress(progressObj.fractionCompleted)
        }

        // start the upload task
        task.resume()
        
    }
    
    
    func downloadFile(
        from urlString : String,
        progress: @escaping (Double) -> Void,
        completion: @escaping (Result<URL, Error>) -> Void
    ) {
        
        // convert string to URL
        guard let downloadURL = URL(string: urlString) else {
            completion(.failure(NetworkServiceError.invalidURL))
            return
        }

        // create a GET request
        var request = URLRequest(url: downloadURL)
        request.httpMethod = "GET"
        request.setValue("true", forHTTPHeaderField: "ngrok-skip-browser-warning")

        // create a download task
        let task = session.downloadTask(with: request) { tempURL, response, error in
            // Handle network errors
            if let error = error {
                completion(.failure(NetworkServiceError.downloadFailed(error.localizedDescription)))
                return
            }

            // validate response
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkServiceError.invalidResponse))
                return
            }

            // check HTTP status
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkServiceError.httpError(statusCode: httpResponse.statusCode)))
                return
            }

            // validate the downloaded file URL
            guard let tempURL = tempURL else {
                completion(.failure(NetworkServiceError.noData))
                return
            }

            // return the temporary file URL — it’s ready for extraction
            completion(.success(tempURL))
        }

        // observe progress updates
        let _ = task.progress.observe(\.fractionCompleted) { progressObj, _ in
            DispatchQueue.main.async {
                progress(progressObj.fractionCompleted)
            }
        }

        // start the download
        task.resume()
    }
        

    
    
    
    
    
    
}
