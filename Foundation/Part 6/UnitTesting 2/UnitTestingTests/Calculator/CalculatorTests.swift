//
//  CalculatorTests.swift
//

import XCTest
@testable import UnitTesting

final class CalculatorTests: XCTestCase {
    var calculator: Calculator!
    
    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }
    
    override func tearDown() {
        calculator = nil
        super.tearDown()
    }
    
    // Given two numbers, when multiplying, then the result is their product
    func test_multiplication() {
        let result = calculator.multiply(10, 20)
        XCTAssertEqual(200, result)
    }
    
    // Given a non-zero divisor, when dividing, then the result is the quotient
    func test_divideByNonZero() throws {
        let result = try calculator.divide(10, 2)
        XCTAssertEqual(result, 5, "Expected 10 divided by 2 to be 5, but got \(result) instead")
    }
    
    // Given a zero divisor, when dividing, then it throws a .divisionByZero error
    // use XCTAssertThrowsError, XCTAssertEqual
    func test_divideByZero_throwsError() {
        XCTAssertThrowsError(try calculator.divide(10, 0)) { error in
            XCTAssertEqual(error as? Calculator.CalculatorError,
                           .divisionByZero,
                           "Expected division by zero to throw .divisionByZero error, but got \(error)"
            )
        }
    }
    
    // Check 3 scenarios: < 10, 10, > 10
    // use XCTAssertTrue, XCTAssertFalse
    func test_isGreaterThanTen() {
        XCTAssertTrue(calculator.isGreaterThanTen(11), "Expected 11 to be greater than 10")
        XCTAssertFalse(calculator.isGreaterThanTen(10), "Expected 10 to NOT be greater than 10")
        XCTAssertFalse(calculator.isGreaterThanTen(9), "Expected 9 to NOT be greater than 10")
    }
    
    // Use XCTAssertNotNil and/or XCAssertEqual
    func test_safeSquareRoot_whenPositiveNumber_returnsValue() {
        let result = calculator.safeSquareRoot(25)
        XCTAssertNotNil(result, "Expected non-nil result for square root of 25")
        XCTAssertEqual(result, 5, "Expected square root of 25 to be 5, but got \(String(describing: result)) instead")
    }
    
    // Use XCTAssertNil
    func test_safeSquareRoot_whenNegativeNumber_returnsNil() {
        let result: Double? = calculator.safeSquareRoot(-25)
        XCTAssertNil(result, "Expected square root of -25 to be nil, but got \(String(describing: result)) instead")
        
    }
}
