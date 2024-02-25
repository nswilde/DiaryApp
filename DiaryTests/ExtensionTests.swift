//
//  ExtensionTests.swift
//  DiaryTests
//
//  Created by Nikki Wilde on 25/02/24.
//

import XCTest
import CoreData
@testable import Diary

final class ExtensionTests: BaseTestCase {
    func testIssueTitleUnwrap() {
        let issue = Issue(context: managedObjectContext)

        issue.title = "Example issue"
        XCTAssertEqual(issue.issueTitle, "Example issue", "Changing title should also change issueTitle.")

        issue.issueTitle = "Updated issue"
        XCTAssertEqual(issue.title, "Updated issue", "Changing issueTitle should also change title.")
    }

    func testIssueContentUnwrap() {
        let issue = Issue(context: managedObjectContext)

        issue.content = "Example issue"
        XCTAssertEqual(issue.issueContent, "Example issue", "Changing content should also change issueContent.")

        issue.issueContent = "Updated issue"
        XCTAssertEqual(issue.content, "Updated issue", "Changing issueContent should also change content.")
    }

    func testIssueCreationDateUnwrap() {
        let issue = Issue(context: managedObjectContext)
        let testDate = Date.now

        issue.creationDate = testDate
        XCTAssertEqual(issue.issueCreationDate, testDate, "Changing creationDate should also change issueCreationDate.")
    }

    func testIssueTagsUnwrap() {
        let tag = Tag(context: managedObjectContext)
        let issue = Issue(context: managedObjectContext)

        XCTAssertEqual(issue.issueTags.count, 0, "A new issue should have no tags.")
        issue.addToTags(tag)

        XCTAssertEqual(issue.issueTags.count, 1, "Adding 1 tag to an issue should result in issueTags having count 1.")
    }

    func testIssueTagsList() {
        let tag = Tag(context: managedObjectContext)
        let issue = Issue(context: managedObjectContext)

        tag.name = "My Tag"
        issue.addToTags(tag)

        XCTAssertEqual(issue.issueTagsList, "My Tag", "Adding 1 tag to an issue should make issueTagsList be My Tag.")
    }
}
