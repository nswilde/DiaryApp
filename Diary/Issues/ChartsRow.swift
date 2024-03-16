//
//  ChartsRow.swift
//  Diary
//
//  Created by Nikki Wilde on 17/03/2024.
//

import SwiftUI

struct ChartsRow: View {
    var dataController: DataController

    var body: some View {
        List {
            NavigationLink(destination: LineChartView(dataController: dataController)) {
                Label("Show Charts", systemImage: "chart.xyaxis.line")
            }
        }
    }
}
