import XCTest
import SwiftTreeSitter
import TreeSitterSj

final class TreeSitterSjTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_sj())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading JAVASCRIPT grammar")
    }
}
