//
//  Filter.swift
//  Diary
//
//  Created by Nikki Wilde on 25/01/24.
//

import Foundation

struct Filter: Identifiable, Hashable {
    var id: UUID
    var name: String
    var icon: String
    var minModificationDate = Date.distantPast
    var minCreationDate: Date?
    var maxCreationDate: Date?
    var tag: Tag?

    var activeIssuesCount: Int {
        tag?.tagActiveIssues.count ?? 0
    }

    static var all = Filter(
        id: UUID(),
        name: "All Diary Entries",
        icon: "tray"
    )
    static var recent = Filter(
        id: UUID(),
        name: "Recent Diary Entries",
        icon: "clock",
        minModificationDate: .now.addingTimeInterval(86400 * -7)
    )
//    static var lastYear = Filter(
//        id: UUID(),
//        name: "Last 12 months",
//        icon: "calendar",
//        minCreationDate: <#T##Date?#>,
//        maxCreationDate: <#T##Date?#>
//    )
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: Filter, rhs: Filter) -> Bool {
        lhs.id == rhs.id
    }
}
