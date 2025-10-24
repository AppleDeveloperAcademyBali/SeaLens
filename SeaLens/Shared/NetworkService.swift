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
    func 
    
    
    
}
