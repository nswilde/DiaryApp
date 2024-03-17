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

            #if DEBUG
            Button("DEBUG: Print issues") {
                dataController.deleteAll()
                printData()
            }
            #endif

            Chart {
                ForEach(issues, id: \.id) { issue in
                    LineMark(x: .value("Date", issue.creationDate!),
                             y: .value("Score", issue.score))
                    .foregroundStyle(by: .value("Entry type", issue.score))
                    .symbol {
                        Circle()
                    }
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .padding()

            Text("Your mood scores for the last (months/years)")
                .opacity(0.5)
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

    func printData() {
        dataController.createChartData()
    }
}

#Preview {
    LineChartView(dataController: .preview)
}
