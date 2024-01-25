//
//  DiaryApp.swift
//  Diary
//
//  Created by Nikki Wilde on 22/01/24.
//

import SwiftUI

@main
struct DiaryApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                SidebarView()
            } content: {
                ContentView()
            } detail: {
                DetailView()
            }
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
