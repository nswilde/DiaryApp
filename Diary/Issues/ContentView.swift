//
//  ContentView.swift
//  Diary
//
//  Created by Nikki Wilde on 22/01/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.requestReview) var requestReview
    @ObservedObject var viewModel: ViewModel

    private let newIssueActivity = "com.NikkiW.Diary.newIssue"

    var body: some View {
        List(selection: $viewModel.selectedIssue) {
            ForEach(viewModel.dataController.issuesForSelectedFilter()) { issue in
                IssueRow(issue: issue)
            }
            .onDelete(perform: viewModel.delete)
        }
        .navigationTitle("Diary Entries")
        .searchable(text: $viewModel.filterText,
                    tokens: $viewModel.filterTokens,
                    suggestedTokens: .constant(viewModel.suggestedFilterTokens),
                    prompt: "Filter entries, or type # to add tags"
            ) { tag in
            Text(tag.tagName)
        }
        .toolbar(content: ContentViewToolbar.init)
        // Disabled popup for debug, re-enable later
        // .onAppear(perform: askForReview)
        .onOpenURL(perform: openURL)
        .userActivity(newIssueActivity) { activity in
            activity.isEligibleForPrediction = true
            activity.title = "New Entry"
        }
        .onContinueUserActivity(newIssueActivity, perform: resumeActivity)
    }

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }

    func askForReview() {
        if viewModel.shouldRequestReview {
            requestReview()
        }
    }

    func openURL(_ url: URL) {
        if url.absoluteString.contains("newIssue") {
            viewModel.dataController.newIssue()
        }
    }

    func resumeActivity(_ userActivity: NSUserActivity) {
        viewModel.dataController.newIssue()
    }
}

#Preview {
    ContentView(dataController: .preview)
}
