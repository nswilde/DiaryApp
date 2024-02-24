//
//  DiaryTests.swift
//  DiaryTests
//
//  Created by Nikki Wilde on 25/02/24.
//

import CoreData
import XCTest
@testable import Diary

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
