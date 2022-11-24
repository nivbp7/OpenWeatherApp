//
//  OpenWeatherAppTests.swift
//  OpenWeatherAppTests
//
//  Created by niv ben-porath on 24/11/2022.
//  Copyright © 2022 nbpApps. All rights reserved.
//

import XCTest
@testable import OpenWeatherApp


class OpenWeatherAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let date = Date().startOfDay
        let time = date?.toString(with: .time)
        XCTAssertEqual(time, "00:00:00")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
