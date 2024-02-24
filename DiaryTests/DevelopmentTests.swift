//
//  DevelopmentTests.swift
//  DiaryTests
//
//  Created by Nikki Wilde on 25/02/24.
//

import CoreData
import XCTest
@testable import Diary

final class DevelopmentTests: BaseTestCase {
    func testSampleDataCreationWorks() {
        dataController.createSampleData()

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 5, "There should be 5 sample tags")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 50, "There should be 50 sample issues")
    }

    func testDeleteAllCountIsZero() {
        dataController.createSampleData()
        dataController.deleteAll()

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 0, "There should be 0 tags")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 0, "There should be 0 issues")
    }

    func testExampleTagHasNoIssues() {
        let tag = Tag.example
        XCTAssertEqual(tag.issues?.count, 0, "The example tag should have 0 issues.")
    }

    func testExampleIssueHasNoTags() {
        let issue = Issue.example
        XCTAssertEqual(issue.priority, 2, "Example should be high priority.")
    }
}
