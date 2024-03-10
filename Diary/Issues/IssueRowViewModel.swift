//
//  IssueRowViewModel.swift
//  Diary
//
//  Created by Nikki Wilde on 27/02/24.
//

import Foundation
import SwiftUI

extension IssueRow {
    @dynamicMemberLookup
    class ViewModel: ObservableObject {
        let issue: Issue

        var iconOpacity: Color {
            if issue.priority == 2 {
                return Color.red
            }
            if issue.priority == 1 {
                return Color.yellow
            } else {
                return Color.green
            }
        }

        var iconIdentifier: String {
            issue.priority == 2 ? "\(issue.issueTitle) High Priority" : ""
        }

        var accessibilityHint: String {
            issue.priority == 2 ? "High priority" : ""
        }

        var accessibilityCreationDate: String {
            issue.issueCreationDate.formatted(date: .abbreviated, time: .omitted)
        }

        var creationDate: String {
            issue.issueCreationDate.formatted(date: .numeric, time: .omitted)
        }

        init(issue: Issue) {
            self.issue = issue
        }

        subscript<Value>(dynamicMember keyPath: KeyPath<Issue, Value>) -> Value {
            issue[keyPath: keyPath]
        }
    }
}
