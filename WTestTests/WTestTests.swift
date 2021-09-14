//
//  WTestTests.swift
//  WTestTests
//
//  Created by Anderson F Carvalho on 13/09/21.
//

import XCTest
@testable import WTest

class WTestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testZipCodeDownload() {
        let expectation = self.expectation(description: "Downloading")
        ZipCodeManager.shared.downloadZipCode { zipCodeList in
            XCTAssertTrue(zipCodeList.count > 0)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    func testZipCodeSavedLocal() {
        let zipCode = ZipCodeModel()
        zipCode.extCodPostal = "123"
        zipCode.numCodPostal = "12345"
        let zipCodeListMock = [zipCode]
        let expectation = self.expectation(description: "Saving")
        
        ZipCodeManager.shared.saveZipCode(zipCodeList: zipCodeListMock) { status in
            XCTAssertTrue(status)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
