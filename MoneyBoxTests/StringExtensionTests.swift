import XCTest

@testable import MoneyBox

final class StringExtensionTests: XCTestCase {
    
    func test_StringExtension_asCurrency_successful() throws {
        let value: Double = 12.34
        XCTAssertEqual(value.description.asCurrency, "£12.34")
    }
    
    func test_StringExtension_asCurrency_roundsDown() throws {
        let value: Double = 12.349
        XCTAssertEqual(value.description.asCurrency, "£12.34")
    }
}
