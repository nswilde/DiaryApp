//
//  ChartData.swift
//  Diary
//
//  Created by Nikki Wilde on 16/03/2024.
//

//import Foundation
//import Charts
//
//struct ChartData {
//    var id = UUID()
//    var date: Date
//    var score: Int16
//}
//
//class DataForChart: Identifiable, Equatable, Comparable {
//    @Published var chartData = [ChartData]()
//
//    init(chartData: [ChartData]) {
//        self.chartData = chartData
//    }
//
//    static func == (lhs: date, rhs: date) -> Bool {
//        let left = lhs.date
//        let right = rhs.date
//
//        if left == right {
//            return lhs.date < rhs.date
//        } else {
//            return left < right
//        }
//    }
//
//    public static func <(lhs: date , rhs: date) -> Bool {
//        let left = lhs.date
//        let right = rhs.date
//
//        if left == right {
//            return lhs.date < rhs.date
//        } else {
//            return left < right
//        }
//    }
//}
