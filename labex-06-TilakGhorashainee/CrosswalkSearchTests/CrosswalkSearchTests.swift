//
//  CrosswalkSearchTests.swift
//  CrosswalkSearchTests
//
//  Created by Paul Inventado on 4/8/22.
//

@testable import CrosswalkSearch
import XCTest

class CrosswalkSearchTests: XCTestCase {
    var fileURL: URL!

    override func setUp() {
        let documentsDirectory =
            FileManager.default.urls(for: .documentDirectory,
                                     in: .userDomainMask).first!
        fileURL =
            documentsDirectory.appendingPathComponent("crosswalks")
                .appendingPathExtension("plist")
    }

    func testPropertyAdditions() {
        let mapsAPI = MapsAPIResult(type: "", query: [], features: [], attribution: " ")
        _ = mapsAPI.attribution

        let crossWalk = Crosswalk(text: "", place_name: "", center: [])
        _ = crossWalk.center
    }

    func testSaveHistory() {
        let history = SearchHistory()
        history.searchStrings = ["CSUF", "Titan Hall"]
        history.saveHistory()

        let propertyListDecoder = PropertyListDecoder()
        var decodedHistoryCheck: [String]?
        if let retrievedHistory = try? Data(contentsOf: fileURL),
           let decodedHistory = try?
           propertyListDecoder.decode([String].self,
                                      from: retrievedHistory)
        {
            decodedHistoryCheck = decodedHistory
            XCTAssertEqual(decodedHistory, ["CSUF", "Titan Hall"])
        }
        XCTAssertNotNil(decodedHistoryCheck)
    }

    func testLoadHistory() {
        let searchStrings = ["Titan Hall", "CSUF"]
        let propertyListEncoder = PropertyListEncoder()
        if let encodedHistory = try? propertyListEncoder.encode(searchStrings) {
            try? encodedHistory.write(to: fileURL,
                                      options: .noFileProtection)
        }

        let history = SearchHistory()
        history.loadHistory()
        XCTAssertEqual(history.searchStrings, searchStrings)
    }

    func testInitLoadHistory() {
        let searchStrings = ["Titan Hall", "CSUFX", "ECS Building"]
        let propertyListEncoder = PropertyListEncoder()
        if let encodedHistory = try? propertyListEncoder.encode(searchStrings) {
            try? encodedHistory.write(to: fileURL,
                                      options: .noFileProtection)
        }

        let history = SearchHistory()

        XCTAssertEqual(history.searchStrings, searchStrings)
    }
}
