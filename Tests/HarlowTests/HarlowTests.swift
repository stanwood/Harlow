import XCTest
@testable import Harlow

final class HarlowTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Harlow().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
