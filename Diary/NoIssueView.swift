//
//  NoIssueVIew.swift
//  Diary
//
//  Created by Nikki Wilde on 31/01/24.
//

import SwiftUI

struct NoIssueView: View {
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        Text("No issue Selected")
            .font(.title)
            .foregroundStyle(.secondary)
        
        Button("New Issue", action: dataController.newIssue)
    }
}

#Preview {
    NoIssueView()
}
