//
//  WeatherMapViewModelTest.swift
//  WeatherDetailsTests
//
//  Created by Pranith Margam on 02/05/21.
//

import XCTest

@testable import WeatherDetails

class WeatherMapViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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

    func testFiliterDataListByDateWithDifferentDateValue() {
        let testWeatherMap = getWeatherMap1()
        XCTAssertEqual(testWeatherMap.filiterDataListByDate.count, 4, "")
    }
    
    func testFiliterDataListByDateWithDifferentMonthAndDateValue() {
        let testWeatherMap = getWeatherMap2()
        XCTAssertEqual(testWeatherMap.filiterDataListByDate.count, 8, "")
    }
    
    func testFiliterDataListByDateWithEmptyArray() {
        let testWeatherMap = getWeatherMap3()
        XCTAssertEqual(testWeatherMap.filiterDataListByDate.count, 0, "")
    }
    
    func testDateString() {
        let main = WeatherMap.Data.Main(temp: 12, feels_like: 22, pressure: 12, sea_level: 12, humidity: 12)
        let weather = WeatherMap.Data.Weather(id: 1, main: "", description: "", icon: "")
        let sys = WeatherMap.Data.Sys(pod: "")
        let data1 = WeatherMap.Data(dt: 123, dt_txt: "2021-05-01 21:00:00", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)
        XCTAssertEqual(data1.dateString, "May-01", "")
        
        let data2 = WeatherMap.Data(dt: 123, dt_txt: "2021-01-01 21:00:00", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)
        XCTAssertEqual(data2.dateString, "Jan-01", "")
        
        let data3 = WeatherMap.Data(dt: 123, dt_txt: "2021-01-01", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)
        XCTAssertEqual(data3.dateString, "", "Different Date formate from API")
    }
    
    private func getWeatherMap1() -> WeatherMap {
        let main = WeatherMap.Data.Main(temp: 12, feels_like: 22, pressure: 12, sea_level: 12, humidity: 12)
        let weather = WeatherMap.Data.Weather(id: 1, main: "", description: "", icon: "")
        let sys = WeatherMap.Data.Sys(pod: "")
        let data1 = WeatherMap.Data(dt: 123, dt_txt: "2021-05-01 21:00:00", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)
        let data2 = WeatherMap.Data(dt: 123, dt_txt: "2021-05-01 21:00:00", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)
        let data3 = WeatherMap.Data(dt: 123, dt_txt: "2021-05-02 21:00:00", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)
        let data4 = WeatherMap.Data(dt: 123, dt_txt: "2021-05-02 21:00:00", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)
        let data5 = WeatherMap.Data(dt: 123, dt_txt: "2021-05-03 21:00:00", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)
        let data6 = WeatherMap.Data(dt: 123, dt_txt: "2021-05-03 21:00:00", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)
        let data7 = WeatherMap.Data(dt: 123, dt_txt: "2021-05-04 21:00:00", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)
        let data8 = WeatherMap.Data(dt: 123, dt_txt: "2021-05-04 21:00:00", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)

        let city = WeatherMap.City(id: 1, name: "1")
        let weatherMap = WeatherMap(cod: "200", message: 0, cnt: 2, list: [data1,data2,data3,data4,data5,data6,data7,data8], city: city)
        return weatherMap
    }
    
    private func getWeatherMap2() -> WeatherMap {
        let main = WeatherMap.Data.Main(temp: 12, feels_like: 22, pressure: 12, sea_level: 12, humidity: 12)
        let weather = WeatherMap.Data.Weather(id: 1, main: "", description: "", icon: "")
        let sys = WeatherMap.Data.Sys(pod: "")
        let data1 = WeatherMap.Data(dt: 123, dt_txt: "2021-05-01 21:00:00", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)
        let data2 = WeatherMap.Data(dt: 123, dt_txt: "2021-04-01 21:00:00", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)
        let data3 = WeatherMap.Data(dt: 123, dt_txt: "2021-05-02 21:00:00", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)
        let data4 = WeatherMap.Data(dt: 123, dt_txt: "2021-04-02 21:00:00", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)
        let data5 = WeatherMap.Data(dt: 123, dt_txt: "2021-05-03 21:00:00", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)
        let data6 = WeatherMap.Data(dt: 123, dt_txt: "2021-04-03 21:00:00", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)
        let data7 = WeatherMap.Data(dt: 123, dt_txt: "2021-05-04 21:00:00", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)
        let data8 = WeatherMap.Data(dt: 123, dt_txt: "2021-04-04 21:00:00", rain: nil, wind: nil, main: main, weather: [weather], sys: sys)

        let city = WeatherMap.City(id: 1, name: "1")
        let weatherMap = WeatherMap(cod: "200", message: 0, cnt: 2, list: [data1,data2,data3,data4,data5,data6,data7,data8], city: city)
        return weatherMap
    }
    
    private func getWeatherMap3() -> WeatherMap {
        let city = WeatherMap.City(id: 1, name: "1")
        let weatherMap = WeatherMap(cod: "200", message: 0, cnt: 2, list: [], city: city)
        return weatherMap
    }
}
