//
//  PerformanceTests.swift
//  DiaryTests
//
//  Created by Nikki Wilde on 26/02/24.
//

import XCTest
@testable import Diary

final class PerformanceTests: BaseTestCase {
    func testAwardCalculationPerformance() {
        for _ in 1...100 {
            dataController.createSampleData()
        }

        let awards = Array(repeating: Award.allAwards, count: 25).joined()
        XCTAssertEqual(awards.count, 500, "This checks the awards count is constant. change this if you add awards.")

        measure {
            _ = awards.filter(dataController.hasEarned)
        }
    }
}
