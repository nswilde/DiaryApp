//
//  SidebarView.swift
//  Diary
//
//  Created by Nikki Wilde on 25/01/24.
//

import SwiftUI

struct SidebarView: View {
    @ObservedObject private var viewModel: ViewModel
    let smartFilters: [Filter] = [.all, .recent]
    @State var selection = 1

    var body: some View {
        TabView(selection: $selection) {
            VStack {
                List(selection: $viewModel.dataController.selectedFilter) {
                    Section("Smart Filters") {
                        ForEach(smartFilters, content: SmartFilterRow.init)
                    }

                    Section("Tags") {
                        ForEach(viewModel.tagFilters) { filter in
                            UserFilterRow(filter: filter, rename: viewModel.rename, delete: viewModel.delete)
                        }
                        .onDelete(perform: viewModel.delete)
                    }
                }
                .toolbar(content: SidebarViewToolbar.init)
            }
            .alert("Rename tag", isPresented: $viewModel.renamingTag) {
                Button("OK", action: viewModel.completeRename)
                Button("Cancel", role: .cancel) { }
                TextField("New name", text: $viewModel.tagName)
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag(1)

            LineChartView(dataController: viewModel.dataController)
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                    Text("Charts")
                }
                .tag(2)
        }
        .navigationTitle(selection == 1 ? "Journal" : "Charts")
    }

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
}

#Preview {
    SidebarView(dataController: .preview)
}
