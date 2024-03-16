//
//  SidebarView-Toolbar.swift
//  Diary
//
//  Created by Nikki Wilde on 21/02/24.
//

import SwiftUI

struct SidebarViewToolbar: View {
    @EnvironmentObject var dataController: DataController

    @State private var showingCharts: Bool = false
    @State private var showingAwards: Bool = false
    @State private var showingStore = false

    var body: some View {
        Button(action: tryNewTag) {
            Label("Add tag", systemImage: "plus")
        }
        .sheet(isPresented: $showingStore) {
            StoreView()
        }
        Button {
            showingAwards.toggle()
        } label: {
            Label("Show awards", systemImage: "rosette")
        }
        .sheet(isPresented: $showingAwards, content: AwardsView.init)
        Button {
            showingCharts.toggle()
            dataController.saveController()
        } label: {
            Label("Show charts", systemImage: "chart.line.uptrend.xyaxis")
        }
        .sheet(isPresented: $showingCharts) {
            LineChartView(dataController: dataController)
        }
        
        #if DEBUG
        Button {
            dataController.deleteAll()
            dataController.createSampleData()
        } label: {
            Label("ADD SAMPLES", systemImage: "flame")
        }
        #endif
    }

    func tryNewTag() {
        if dataController.newTag() == false {
            showingStore = true
        }
    }
}

//#Preview {
//    SidebarViewToolbar()
//}
