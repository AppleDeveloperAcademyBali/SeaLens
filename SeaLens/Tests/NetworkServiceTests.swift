//
//  NetworkServiceTests.swift
//  SeaLensTests
//
//  Created by Shreyas Venadan on 22/10/2025.
//

import XCTest
@testable import SeaLens


class MockURLSession: URLSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    var uploadTaskCalled = false
    
    override func uploadTask(
        with request: URLRequest,
        from bodyData: Data?,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
        ) -> URLSessionUploadTask {
            uploadTaskCalled = true
            return MockURLSessionUploadTask {
                completionHandler(self.data, self.response, self.error)
            }
        }
    
}

class MockURLSessionUploadTask: URLSessionUploadTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}



final class NetworkServiceTests: XCTestCase {
    
    // sut = system under test
    var sut: NetworkService!
    
    override func setUpWithError() throws {
        super.setUp()
        sut = NetworkService()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test When Server Is Healthy
    func testServerHealthSuccess() async throws {
        
        let mockService = MockNetworkService(mockResponse: "status: Healthy Server")
        
        let result = try await mockService.checkServerHealth()
        
        XCTAssertEqual(result, "status: Healthy Server")
        
    }
    
    // MARK: - Test When Server Fails
    func testServerHealthFailure() async {
        
        let mockService = MockNetworkService(shouldFail: true)
        mockService.errorToThrow = .httpError(statusCode: 500)
        
        do {
            _ = try await mockService.checkServerHealth()
            
            // if server does not throw an error (and then go to catch), then it will fail here with this message
            XCTFail("Expected an error to be thrown, but the call succeded")
            
        } catch {
            if case NetworkServiceError.httpError(let code) = error {
                
                // checking if error matches the one we sent
                XCTAssertEqual(code, 500, "Expected a 500 HTTP error")
                
            } else {
                
                // if any other type of error, we display the errowr
                XCTFail("Unexpected error type: \(error)")
            }
            
        }
        
    }
    
    // MARK: - Test Successful Upload
    
    /**
    func testUploadSuccess() {
        
        // create a mock session so no real network request is made
        let mockSession = MockURLSession()
        
        // inject the mock session into NetworkService for testing
        let sut = NetworkService(session: mockSession)
        
        // stimulate a successful server response (HTTP 200)
        mockSession.response = Foundation.HTTPURLResponse(
            url: URL(string: "https://fake.com/upload")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        mockSession.error = nil
        
        // create a temporary dummy file to simulate a video upload
        let tempFileURL = FileManager.default.temporaryDirectory.appendingPathComponent("video.mp4")
        FileManager.default.createFile(atPath: tempFileURL, contents: Data(), attributes: nil)
        
        // set up an expectation to wait for the async completion handler
        let expectation = XCTestExpectation(description: "Upload completes successfully")
        
        // perform the upload, mock instantly returns a fake response
        sut.uploadVideo(fileURL: tempFileURL, progress: { _ in }) { result in
            
            switch result {
            case .success(let message):
                // expecting a success message from NetworkService
                XCTAssertEqual(message, "Upload successful")
            case .failure(let error):
                // if upload fails, test should fail with error
                XCTFail("Expected success but got failure: \(error)")
            }
            expectation.fulfill()
            
        }
                        
                        // wait for asunc operation to finish
                        wait(for: [expectation], timeout: 2.0)
                        
                        
                        
    }
     
     **/
}



