//
//  StaticChartView.swift
//  LineChartExample2
//
//  Created by Nikki Wilde on 10/03/2024.
//

import SwiftUI
import Charts
import CoreData

struct DataPoint: Identifiable {
    var id = UUID()
    var xValue: Int
    var yValue: Int
}

struct LineChartView: View {
    var dataController: DataController
    let issueController: NSFetchedResultsController<Issue>
    var issues = [Issue]()

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
            print("Failed to fetch tags.")
        }
    }

    var body: some View {
        Chart {
            ForEach(issues, id: \.issueCreationDate) { issue in
                LineMark(x: .value("Date", issue.creationDate!),
                         y: .value("Score", issue.score))
                .foregroundStyle(by: .value("Entry type", issue.title ?? "name"))
                .symbol(by: .value("Entry type", issue.title ?? "N/A symbol"))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
}

#Preview {
    LineChartView(dataController: .preview)
}
