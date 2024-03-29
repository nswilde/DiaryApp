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

    var body: some View {
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
            .navigationTitle(viewModel.dataController.appTitle)
    }

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
}

#Preview {
    SidebarView(dataController: .preview)
}
