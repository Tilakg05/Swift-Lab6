//
//  CrosswalkSearchUITests.swift
//  CrosswalkSearchUITests
//
//  Created by Paul Inventado on 4/8/22.
//

import XCTest

extension XCUIElement {
    func clearText() {
        guard let stringValue = value as? String else {
            return
        }

        var deleteString = String()
        for _ in stringValue {
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        typeText(deleteString)
    }
}

class CrosswalkSearchUITests: XCTestCase {
    func testFindAddress() throws {
        let app = XCUIApplication()
        app.launch()

        app.textFields["Crosswalk"].tap()
        app.textFields["Crosswalk"].typeText("CSUF")
        app.keyboards.buttons["return"].tap()
        app.buttons["Find crosswalk"].tap()
        print(app.staticTexts.debugDescription)
        XCTAssert(app.staticTexts["CSUF - Irvine Campus, 3 Banting, Irvine, California 92618, United States"].exists)
    }

    func testFindMap() throws {
        let app = XCUIApplication()
        app.launch()
        app.textFields["Crosswalk"].tap()
        app.textFields["Crosswalk"].typeText("CSUF")
        app.keyboards.buttons["return"].tap()
        app.buttons["Find crosswalk"].tap()
        XCTAssertGreaterThan(app.images.firstMatch.frame.height, -1)
    }

    func testLoadHistory() {
        let app = XCUIApplication()
        app.launch()

        let searchBar = app.textFields["Crosswalk"]

        searchBar.tap()
        searchBar.typeText("CSUF")
        app.keyboards.buttons["return"].tap()
        app.buttons["Find crosswalk"].tap()

        searchBar.tap()
        searchBar.clearText()
        searchBar.typeText("ECS Building")
        app.keyboards.buttons["return"].tap()
        app.buttons["Find crosswalk"].tap()

        searchBar.tap()
        searchBar.clearText()
        searchBar.typeText("Titan Hall")
        app.keyboards.buttons["return"].tap()
        app.buttons["Find crosswalk"].tap()

        searchBar.tap()
        searchBar.clearText()
        searchBar.typeText("Gastronome")
        app.keyboards.buttons["return"].tap()
        app.buttons["Find crosswalk"].tap()

        searchBar.tap()
        searchBar.clearText()
        searchBar.typeText("Pollak Library")
        app.keyboards.buttons["return"].tap()
        app.buttons["Find crosswalk"].tap()

        searchBar.tap()
        searchBar.clearText()
        searchBar.typeText("TSU")
        app.keyboards.buttons["return"].tap()
        app.buttons["Find crosswalk"].tap()

        app.terminate()

        let app2 = XCUIApplication()
        app2.launch()

        XCTAssertFalse(app2.tables.element.cells["CSUF"].exists)
        XCTAssert(app2.tables.element.cells["ECS Building"].exists)
        XCTAssert(app2.tables.element.cells["Titan Hall"].exists)
        XCTAssert(app2.tables.element.cells["Gastronome"].exists)
        XCTAssert(app2.tables.element.cells["Pollak Library"].exists)
        XCTAssert(app2.tables.element.cells["TSU"].exists)
    }
}
