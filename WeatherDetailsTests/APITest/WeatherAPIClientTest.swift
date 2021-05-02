//
//  WeatherAPIClientTest.swift
//  WeatherDetailsTests
//
//  Created by Pranith Margam on 01/05/21.
//

import XCTest

@testable import WeatherDetails

class WeatherAPIClientTest: XCTestCase {

    var weatherApiClient: WeatherAPIClient!
    
    override func setUpWithError() throws {
        weatherApiClient = WeatherAPIClient(session: URLSession.shared)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testResponseSuccess() {
        let exp = expectation(description: "response")

        let location = Location(name: "Bangaluru", latitude: 12.9716, longitude: 77.5946)
        weatherApiClient.fetchWeatherForecast(atLocation: location, completion:  { (result) in
            exp.fulfill()
            switch result {
            case .sucesss(let wheatherMap):
                XCTAssertEqual(wheatherMap.cod, "200")
            case .failure(let error):
                XCTFail("Error in getting respons\(error)")
            }
        })
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
