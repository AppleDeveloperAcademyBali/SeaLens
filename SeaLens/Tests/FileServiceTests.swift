//
//  FileServiceTests.swift
//  SeaLensTests
//
//  Created by Shreyas Venadan on 20/10/2025.
//

import XCTest
import ZipArchive
@testable import SeaLens

// MARK: - File Service Unit Tests
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
    
    
    // MARK: - Zip Extraction Test
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
        
        let content = try String(contentsOf: extractedFile, encoding: .utf8)
        XCTAssertEqual(content, "Hello, World!", "Content should match")
    }
    
    
    // MARK: - Create Unique Extraction Path Test
    func testUniqueExtractionPath() throws {
        
        // create a new instance of the file service
        let fileService = FileService()
        
        // call the function twice
        let path1 = try fileService.createUniqueExtractionPath()
        let path2 = try fileService.createUniqueExtractionPath()

        
        // verify the path has the expected app directory name
        XCTAssertTrue(path1.path.contains("SeaLens"), "Path should include 'SeaLens' directory")
        
        // verify the folder name follows the expected naming conventions
        XCTAssertTrue(path1.lastPathComponent.starts(with: "ExtractedImages_"), "Should create unique folder name")
                      
        // verify parent folder 'SeaLens' exists
        let parentExists = FileManager.default.fileExists(atPath: path1.deletingLastPathComponent().path)
        XCTAssertTrue(parentExists, "Parent directory 'SeaLens' should exist.")
        
        // verify both paths are not the same
        XCTAssertNotEqual(path1.lastPathComponent, path2.lastPathComponent, "Each call should produce a unique folder name")
        
    }
    
    
    // MARK: - Delete File Test
    func testDeleteFile() throws {
        
        // create a test file
        let testFile = testDirectory.appendingPathComponent("fileToDelete.txt")
        try "Delete me".write(
            to: testFile,
            atomically: true,
            encoding: .utf8
        )
        
        // verify file exists before deletion
        XCTAssertTrue(FileManager.default.fileExists(atPath: testFile.path), "File should exist before deletion")
        
        // delete the file
        try fileService.deleteItem(at: testFile)
        
        // verify file no longer exists
        XCTAssertFalse(FileManager.default.fileExists(atPath: testFile.path), "File should not exist after deletion")
        
    }
    
    
    // MARK: - Delete Non-Existent File Text
    func testDeleteFolder() throws {
        
        // create a test folder with files inside
        let testFolder = testDirectory.appendingPathComponent("folderToDelete")
        try FileManager.default.createDirectory(
            at: testFolder,
            withIntermediateDirectories: true
        )
        
        let file1 = testFolder.appendingPathComponent("file1.txt")
        let file2 = testFolder.appendingPathComponent("file2.txt")
        try "File 1 content".write(to: file1, atomically: true, encoding: .utf8)
        try "File 2 content".write(to: file2, atomically: true, encoding: .utf8)
        
        // verify folder exists before deletion
        XCTAssertTrue(FileManager.default.fileExists(atPath: testFolder.path), "Folder should exist before deletion")
        
        // delete the folder
        try fileService.deleteItem(at: testFolder)
        
        // verify the folder no longer exists
        XCTAssertFalse(FileManager.default.fileExists(atPath: testFolder.path), "Folder should not exist after deletion")

    }
    
    
    // MARK: - Delete Non-Existent File Test
    func testDeleteNonExistentFile() throws {
        
        // make the non existent file path
        let nonExistentFile = testDirectory.appendingPathComponent("doesNotExists.txt")
        
        // attempt to delete non-existent file
        do {
            try fileService.deleteItem(at: nonExistentFile)
            XCTFail("Should throw fileNotFound error")
        } catch FileServiceError.fileNotFound {
            XCTAssertTrue(true, "Correctly threw fileNotFound error")
        } catch {
            XCTFail("Wrong error type: \(error)")
        }
        
    }
    

    
}

