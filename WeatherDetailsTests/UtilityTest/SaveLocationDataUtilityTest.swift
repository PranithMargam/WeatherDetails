//
//  SaveLocationDataUtilityTest.swift
//  WeatherDetailsTests
//
//  Created by Pranith Margam on 01/05/21.
//

import XCTest

@testable import WeatherDetails

class SaveLocationDataUtilityTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        UserDefaults.standard.removeObject(forKey: SaveLocationDataUtility.bookmarkedLocationsKey)

    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetBookmarkedLocations() {
        UserDefaults.standard.removeObject(forKey: SaveLocationDataUtility.bookmarkedLocationsKey)
        XCTAssertEqual(SaveLocationDataUtility.getBookmarkedLocations(), [], "removed bookmarks")
        let testUser1 = getTestLocation(withName: "Bangaluru")
        SaveLocationDataUtility.saveBookmarkedlocations([testUser1])
        XCTAssertEqual(SaveLocationDataUtility.getBookmarkedLocations().count, 1, "")
        XCTAssertEqual(SaveLocationDataUtility.getBookmarkedLocations().first?.name, "Bangaluru", "")
    }
    
    func testSaveBookmarkedLocations() {
        UserDefaults.standard.removeObject(forKey: SaveLocationDataUtility.bookmarkedLocationsKey)
        let testUser1 = getTestLocation(withName: "Hyderabad")
        SaveLocationDataUtility.saveBookmarkedlocations([testUser1])
        XCTAssertEqual(SaveLocationDataUtility.getBookmarkedLocations().count, 1, "")
        XCTAssertEqual(SaveLocationDataUtility.getBookmarkedLocations().first?.name, "Hyderabad", "")
    }
    
    func testRemoveAllBookmarks() {
        let testUser1 = getTestLocation(withName: "Bangaluru")
        SaveLocationDataUtility.saveBookmarkedlocations([testUser1])
        XCTAssertEqual(SaveLocationDataUtility.getBookmarkedLocations().count, 1, "")
        SaveLocationDataUtility.removeAllBookmarks()
        XCTAssertEqual(SaveLocationDataUtility.getBookmarkedLocations().count, 0, "")
    }
    
    func testUnitSystemName() {
        //unitSystemKey
        UserDefaults.standard.removeObject(forKey: SaveLocationDataUtility.unitSystemKey)
        XCTAssertEqual(UnitSystem.lastSavedUnit(), .metric, "defalut value")
        SaveLocationDataUtility.saveUnitValue(unit: .imperial)
        XCTAssertEqual(UnitSystem.lastSavedUnit(), .imperial, "Stored value")
    }
    
    private func getTestLocation(withName name: String) -> Location {
        return Location(name: name, latitude: 0.0, longitude: 0.0)
    }
    
}
