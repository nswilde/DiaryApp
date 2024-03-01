//
//  ContentView.swift
//  Diary
//
//  Created by Nikki Wilde on 22/01/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.requestReview) var requestReview
    @StateObject var viewModel: ViewModel

    var body: some View {
        List(selection: $viewModel.selectedIssue) {
            ForEach(viewModel.dataController.issuesForSelectedFilter()) { issue in
                IssueRow(issue: issue)
            }
            .onDelete(perform: viewModel.delete)
        }
        .navigationTitle("Issues")
        .searchable(text: $viewModel.filterText,
                    tokens: $viewModel.filterTokens,
                    suggestedTokens: .constant(viewModel.suggestedFilterTokens),
            prompt: "Filter Issues"
            ) { tag in
            Text(tag.tagName)
        }
        .toolbar(content: ContentViewToolbar.init)
        .onAppear(perform: askForReview)
    }

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    func askForReview() {
        if viewModel.shouldRequestReview {
            requestReview()
        }
    }
}

#Preview {
    ContentView(dataController: .preview)
}
