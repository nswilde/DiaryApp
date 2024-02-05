//
//  DetailView.swift
//  Diary
//
//  Created by Nikki Wilde on 25/01/24.
//

import SwiftUI

//add extension to support macos later
//extension View {
//    func inlineNavigationBar() -> some View {
//        #if os(iOS)
//        self.navigationBarTitleDisplayMode(.inline)
//        #else
//        self
//        #endif
//    }
//    
//}

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
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView()
}
