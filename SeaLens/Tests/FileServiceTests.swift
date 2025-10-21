//
//  FileServiceTests.swift
//  SeaLensTests
//
//  Created by Shreyas Venadan on 20/10/2025.
//

import XCTest
import ZipArchive
@testable import SeaLens

final class FileServiceTests: XCTestCase {
    
    var fileService: FileService!
    var testDirectory: URL!

    override func setUpWithError() throws {
        try super.setUpWithError()
        fileService = FileService()
        
        // create temporary test directory
        testDirectory = FileManager.default.temporaryDirectory
            .appendingPathComponent("FileServiceTests_\(UUID().uuidString)")
        
        try FileManager.default.createDirectory(
            at: testDirectory,
            withIntermediateDirectories: true
        )
    }

    override func tearDownWithError() throws {
        // clean up
        try? FileManager.default.removeItem(at: testDirectory)
        fileService = nil
        testDirectory = nil
        try super.tearDownWithError()
    }

    func testExtraction() async throws {
        // create a test file
        let testFile = testDirectory.appendingPathComponent("test.txt")
        try "Hello, World!".write(to: testFile, atomically: true, encoding: .utf8)
        
        // create a zip file from it
        let zipURL = testDirectory.appendingPathComponent("test.zip")
        let zipCreated = SSZipArchive.createZipFile(
            atPath: zipURL.path,
            withFilesAtPaths: [testFile.path]
        )
        XCTAssertTrue(zipCreated, "Zip file should be created")
        
        // extract the zip
        let extractionFolder = testDirectory.appendingPathComponent("extracted")
        let result = try await fileService.extract(
            from: zipURL.path,
            to: extractionFolder.path
        )
        
        // verify extraction worked
        XCTAssertTrue(result, "Extraction should succeed")
        
        let extractedFile = extractionFolder.appendingPathComponent("test.txt")
        XCTAssertTrue(
            FileManager.default.fileExists(atPath: extractedFile.path),
            "Extracted file should exist"
        )
        
        let content = try String(contentsOf: extractedFile)
        XCTAssertEqual(content, "Hello, World!", "Content should match")
    }
}
