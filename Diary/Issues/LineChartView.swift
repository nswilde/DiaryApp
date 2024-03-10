//
//  StaticChartView.swift
//  LineChartExample2
//
//  Created by Nikki Wilde on 10/03/2024.
//

import SwiftUI
import Charts

struct TestData: Identifiable, Equatable {
    let year: Date

    let score: Double

    var id: Date { year }

    static var example: [TestData] {
        [TestData(year: Date.now, score: 15),
         TestData(year: Date.now.addingTimeInterval(86400), score: 20),
         TestData(year: Date.now.addingTimeInterval(2186400), score: 65),
         TestData(year: Date.now.addingTimeInterval(1386400), score: 90),
         TestData(year: Date.now.addingTimeInterval(1586400), score: 75)]
    }
}

struct LineChartView: View {
    let exampleData = TestData.example

    var data: [(type: String, testData: [TestData])] {
        [(type: "test", testData: exampleData)]
    }

    var dataController: DataController
    let issues = [Issue]()

    init(dataController: DataController) {
        self.dataController = dataController
    }

    let testArray: [Double] = [1.0, 2.0, 3.0, 4.0, 5.0]

    var body: some View {
        VStack {
            Chart {
                ForEach(data, id: \.type) { dataSeries in
                    ForEach(dataSeries.testData) { data in
                        LineMark(x: .value("Year", data.year),
                                y: .value("Population", data.score))
                    }
                    .foregroundStyle(by: .value("Pet type", dataSeries.type))
                    .symbol(by: .value("Pet type", dataSeries.type))
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .padding()
        }

    }
}

#Preview {
    LineChartView(dataController: .preview)
}
