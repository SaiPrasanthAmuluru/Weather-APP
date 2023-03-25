//
//  APIConstantsForUrlTestCases.swift
//  Weather AppTests
//
//  Created by Sai Prasanth Amuluru on 25/03/23.
//

import XCTest
@testable import Weather_App
final class APIConstantsForUrlTestCases: XCTestCase {
var apiCOnstants = ApiEndPoints()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testGeoApiUrl(){
        let geoUrl = ApiEndPoints.getGeoCodeUrl(input: "London")
        XCTAssertTrue(geoUrl.count > 0)
    }
    func testWeatherApiUrl(){
        let geoUrl = ApiEndPoints.getweatherInfoUrl(input: GeoCodeResponseModel(name: "London", lat: 51.5085, lon: -0.1257, country: "GB", state: ""))
        XCTAssertTrue(geoUrl.count > 0)
    }
    func testImageApiUrl(){
        let geoUrl = ApiEndPoints.getWeatherImage(input: "03d")
        XCTAssertTrue(geoUrl.count > 0)
    }
}
