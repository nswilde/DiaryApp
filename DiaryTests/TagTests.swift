//
//  TagTests.swift
//  DiaryTests
//
//  Created by Nikki Wilde on 25/02/24.
//

import CoreData
import XCTest
@testable import Diary

final class TagTests: BaseTestCase {
    func testCreatingTagsAndIssues() {
        let targetCount = 10

        for _ in 0..<targetCount {
            let tag = Tag(context: managedObjectContext)

            for _ in 0..<targetCount {
                let issue = Issue(context: managedObjectContext)
                tag.addToIssues(issue)
            }
        }

        XCTAssertEqual(
            dataController.count(
            for: Tag.fetchRequest()), targetCount,
            "There should be \(targetCount) tags."
        )
        XCTAssertEqual(
            dataController.count(
            for: Issue.fetchRequest()), targetCount * targetCount,
            "There should be \(targetCount * targetCount) issues."
        )
    }

    func testDeletingTagDoesNotDeleteIssues() throws {
        dataController.createSampleData()

        let request = NSFetchRequest<Tag>(entityName: "Tag")
        let tags = try managedObjectContext.fetch(request)

        dataController.delete(tags[0])

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 4,
                       "There should be 4 tags after deleting 1 from our sample data.")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 50,
                       "There should be 50 issues after deleting 1 from our sample data.")
    }
}
