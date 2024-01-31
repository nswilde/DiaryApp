//
//  DetailView.swift
//  Diary
//
//  Created by Nikki Wilde on 25/01/24.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        VStack {
            if let issue = dataController.selectedIssue {
                IssueView(issue: issue)
            } else {
                NoIssueView()
            }
        }
    }
}

#Preview {
    DetailView()
}
