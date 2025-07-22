//
//  UsersViewModelTests.swift
//  UnitTesting
//

@testable import UnitTesting
import XCTest

class UsersViewModelTests: XCTestCase {
    var mockService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
    }
    
    override func tearDown() {
        mockService = nil
        super.tearDown()
    }
    
    // assert that sut.fetchUsers(completion: {}) calls appropriate method of api service
    // use XCAssertEqual, fetchUsersCallsCount
    func test_viewModel_whenFetchUsers_callsApiService() {
        let sut = makeSut()
        let expectation = self.expectation(description: "callsApiService called")
        
        sut.fetchUsers {
            XCTAssertEqual(self.mockService.fetchUsersCallsCount, 1, "Expected fetchusersCallCount to be 1, got \(self.mockService.fetchUsersCallsCount)")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }

    // assert that the passed url to api service is correct
    func test_viewModel_whenFetchUsers_passesCorrectUrlToApiService() {
        let sut = makeSut()
        let expectation = self.expectation(description: "passesCorrectUrlToApiService called")
        
        sut.fetchUsers {
            XCTAssertEqual(self.mockService.lastFetchedURLString, "https://jsonplaceholder.typicode.com/users", "Expected URL to be https://jsonplaceholder.typicode.com/users, got \(String(describing: self.mockService.lastFetchedURLString)) instead")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        
    }

    // assert that view model users are updated and error message is nil
    func test_viewModel_fetchUsers_whenSuccess_updatesUsers() {
        mockService.fetchUsersResult = .success(
            [User(id: 1, name: "name", username: "surname", email: "user@email.com")]
        )
        let sut = makeSut()
        let expectation = self.expectation(description: "whenSuccess called")
        
        sut.fetchUsers {
            XCTAssertEqual(sut.users.count, 1, "Expected 1 user, got \(sut.users.count) instead")
            XCTAssertEqual(sut.users[0].id, 1, "Expected 1st user ID to be 1, got \(sut.users[0].id) instead")
            XCTAssertEqual(sut.users[0].name, "name", "Expected name to be name, got \(sut.users[0].name) instead")
            XCTAssertEqual(sut.users[0].username, "surname", "Expected username to be surname, got \(sut.users[0].username) instead")
            XCTAssertEqual(sut.users[0].email, "user@email.com", "Expected email to be user@email.com, got \(sut.users[0].email) instead")
            XCTAssertNil(sut.errorMessage, "Expected error message to be nil on success")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    // assert that view model error message is "Unexpected error"
    func test_viewModel_fetchUsers_whenInvalidUrl_updatesErrorMessage() {
        let sut = makeSut()
        let expectation = self.expectation(description: "whenInvalidUrl called")
        
        sut.fetchUsers {
            XCTAssertEqual(sut.errorMessage, "Unexpected error", "Expected message Unexpected error, got \(String(describing: sut.errorMessage)) instead")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    // assert that view model error message is "Unexpected error"
    func test_viewModel_fetchUsers_whenUnexectedFailure_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.unexpected)
        let sut = makeSut()
        let expectation = self.expectation(description: "whenUnexectedFailure called")
        
        sut.fetchUsers {
            XCTAssertEqual(sut.errorMessage, "Unexpected error", "Expected message Unexpected error, got \(String(describing: sut.errorMessage)) instead")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    // assert that view model error message is "Error parsing JSON"
    func test_viewModel_fetchUsers_whenParsingFailure_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.parsingError)
        let sut = makeSut()
        let expectation = self.expectation(description: "whenParsingFailure called")
        
        sut.fetchUsers {
            XCTAssertEqual(sut.errorMessage, "Error parsing JSON", "Expected message Error parsing JSON, got \(String(describing: sut.errorMessage)) instead")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    // fetch users with successful result and after calling clear() assert users are empty
    func test_viewModel_clearUsers() {
        mockService.fetchUsersResult = .success(
            [User(id: 1, name: "name", username: "surname", email: "user@email.com")]
        )
        let sut = makeSut()
        let expectation = self.expectation(description: "clearUsers called")
        
        sut.clearUsers()
        XCTAssertTrue(sut.users.isEmpty, "Expected users array to be empty, got \(sut.users) instead")
        expectation.fulfill()
        waitForExpectations(timeout: 1)
    }

    private func makeSut() -> UsersViewModel {
        UsersViewModel(apiService: mockService)
    }
}
