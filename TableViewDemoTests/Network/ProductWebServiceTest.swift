//
//  ProductWebServiceTest.swift
//  TableViewDemoTests
//
//  Created by Jitendra Kumar on 18/07/20.
//  Copyright © 2020 Jitendra Kumar. All rights reserved.
//

import XCTest
@testable import TableViewDemo

class ProductWebServiceTest: XCTestCase {
    
    var sut:WebService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        sut = WebService(urlString: ProductConstant.productURLString, urlSession: urlSession)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    
    func testProductWebService_WhenGivenSuccessfullResponse_ReturnsSuccess() {
        
        // Arrange
        let jsonString = "{\"title\":\"About Canada\"}"
        MockURLProtocol.stubResponseData =  jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Product Web Service Response Expectation")
        
        // Act
        sut.getProducts() { (productResponseModel, error) in
            XCTAssertEqual(productResponseModel?.title, "About Canada")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
        
    }

    func testProductWebservice_WhenEmptyURLStringProvided_ReturnsError() {
        // Arrange
        let expectation = self.expectation(description: "An empty request URL string expectation")
        
        sut = WebService(urlString: "")
        
        // Act
        sut.getProducts() { (productResponseModel, error) in
            
            // Assert
            XCTAssertEqual(error, ProductAPIError.invalidRequestURLString, "The Product() method did not return an expected error for an invalidRequestURLString error")
            XCTAssertNil(productResponseModel, "When an invalidRequestURLString takes place, the response model must be nil")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testProductWebService_WhenURLRequestFails_ReturnsErrorMessageDescription() {
        
        // Arrange
        let expectation = self.expectation(description: "A failed Request expectation")
        let errorDescription = "A localized description of an error"
        MockURLProtocol.error = ProductAPIError.failedRequest(description:errorDescription)
        
        // Act
        sut.getProducts() { (productResponseModel, error) in
            // Assert
            XCTAssertEqual(error, ProductAPIError.failedRequest(description:errorDescription), "The Product() method did not return an expecter error for the Failed Request")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }
}
