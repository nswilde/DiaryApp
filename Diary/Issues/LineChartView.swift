//
//  StaticChartView.swift
//  LineChartExample2
//
//  Created by Nikki Wilde on 10/03/2024.
//

import SwiftUI
import Charts
import CoreData

struct LineChartView: View {
    var dataController: DataController
    var issues = [Issue]()
    let issueController: NSFetchedResultsController<Issue>
    let fetchRequest: NSFetchRequest<Issue> = Issue.fetchRequest()

    var body: some View {
        ScrollView {

            Button("Print issues") {
                sortData()
            }
            Chart {
                ForEach(issues, id: \.id) { issue in
                    LineMark(x: .value("Date", issue.creationDate!),
                             y: .value("Score", issue.score))
                    .foregroundStyle(by: .value("Entry type", issue.title ?? "name"))
                    .symbol(by: .value("Entry type", issue.title ?? "N/A symbol"))
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .padding()
        }
        .navigationTitle("Your chart data")
    }

    init(dataController: DataController) {
        self.dataController = dataController

        let request = Issue.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Issue.title, ascending: true)]

        issueController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: dataController.container.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )

        do {
            try issueController.performFetch()
            issues = issueController.fetchedObjects ?? []
        } catch {
            print("Failed to fetch issues.")
        }
    }

    func sortData() {
        for amount in 0..<issues.count {
            print(issues[amount].creationDate ?? Date.distantPast)
        }
    }
}

#Preview {
    LineChartView(dataController: .preview)
}
