//
//  APIServiceTests.swift
//  UnitTesting
//

import XCTest
@testable import UnitTesting

final class APIServiceTests: XCTestCase {
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
    }
    
    override func tearDown() {
        mockURLSession = nil
        super.tearDown()
    }
    
    // MARK: Fetch Users
    
    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    // use expectations
    func test_apiService_fetchUsers_whenInvalidUrl_completesWithError() {
        let sut = makeSut()
        let expectation = self.expectation(description: "whenInvalidUrl called")
        
        sut.fetchUsers(urlString: "") { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .invalidUrl, "Expected to get .invalidUrl error but got \(error) instead")
            default:
                XCTFail("Expected failure but got success")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    // assert that method completes with .success(expectedUsers)
    func test_apiService_fetchUsers_whenValidSuccessfulResponse_completesWithSuccess() {
        let response = """
        [
            { "id": 1, "name": "John Doe", "username": "johndoe", "email": "johndoe@gmail.com" },
            { "id": 2, "name": "Jane Doe", "username": "johndoe", "email": "johndoe@gmail.com" }
        ]
        """.data(using: .utf8)
        mockURLSession.mockData = response
        
        let sut = makeSut()
        let expectation = self.expectation(description: "whenValidSuccessfulResponse called")
        
        sut.fetchUsers(urlString: "https://example.com/users") { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 2, "Expected user count to be to but got \(users.count)")
                XCTAssertEqual(users[0].name, "John Doe", "Expected first user name to be 'John Doe' but got '\(users[0].name)'")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        
    }
    
    // assert that method completes with .failure(.parsingError)
    func test_apiService_fetchUsers_whenInvalidSuccessfulResponse_completesWithFailure() {
        let response = """
        [
            {id: 0},
            {id: 1}
        ]
        """.data(using: .utf8)
        mockURLSession.mockData = response
        
        let sut = makeSut()
        let expectation = self.expectation(description: "whenInvalidSuccessfulResponse called")
        
        sut.fetchUsers(urlString: "example.com") { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .parsingError, "Expected .parsingError, got \(error)")
            default:
                XCTFail("Expected .failure, got .success instead")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    // assert that method completes with .failure(.unexpected)
    func test_apiService_fetchUsers_whenError_completesWithFailure() {
        mockURLSession.mockError = URLError(.networkConnectionLost)
        let sut = makeSut()
        let expectation = self.expectation(description: "whenError called")
        
        sut.fetchUsers(urlString: "hello") { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .unexpected, "Expected .unexpected, got \(error)")
            default:
                XCTFail("Expected .failure, got .success")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    // MARK: Fetch Users Async
    
    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    func test_apiService_fetchUsersAsync_whenInvalidUrl_completesWithError() async {
        let sut = makeSut()
        let result = await sut.fetchUsersAsync(urlString: "")
        
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .invalidUrl, "Expected .invalidUrl, got \(error)")
        default:
            XCTFail("Expected .failure, got .success")
        }
    }
    
    // TODO: Implement test
    // add other tests for fetchUsersAsync
    
    func test_apiService_fetchUsersAsync_whenValidSuccessfulResponse_completesWithSuccess() async {
        let response = """
        [
            { "id": 1, "name": "John Doe", "username": "johndoe", "email": "johndoe@gmail.com" },
            { "id": 2, "name": "Jane Doe", "username": "johndoe", "email": "johndoe@gmail.com" }
        ]
        """.data(using: .utf8)
        mockURLSession.mockData = response
        let sut = makeSut()
        let result = await sut.fetchUsersAsync(urlString: "example.com")
        
        switch result {
        case .success(let users):
            XCTAssertEqual(users.count, 2, "Expected user count to be to but got \(users.count)")
            XCTAssertEqual(users[0].name, "John Doe", "Expected first user name to be 'John Doe' but got '\(users[0].name)'")
        case .failure:
            XCTFail("Expected success but got failure")
        }
    }
    
    func test_apiService_fetchUsersAsync_whenInvalidSuccessfulResponse_completesWithFailure() async {
        let response = """
        [
            {id: 0},
            {id: 1}
        ]
        """.data(using: .utf8)
        mockURLSession.mockData = response
        let sut = makeSut()
        let result = await sut.fetchUsersAsync(urlString: "example.com")
        
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .parsingError, "Expected .parsingError, got \(error)")
        default:
            XCTFail("Expected .failure, got .success instead")
        }
    }
    
    func test_apiService_fetchUsersAsync_whenError_completesWithFailure() async {
        mockURLSession.mockError = URLError(.networkConnectionLost)
        let sut = makeSut()
        let result = await sut.fetchUsersAsync(urlString: "hello")
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .unexpected, "Expected .unexpected, got \(error)")
        default:
            XCTFail("Expected .failure, got .success")
        }
    }
    
    private func makeSut() -> APIService {
        APIService(urlSession: mockURLSession)
    }
}
