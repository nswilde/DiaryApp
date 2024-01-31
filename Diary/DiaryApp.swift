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
    @Environment(\.scenePhase) var scenePhase
    
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
//                .onChange(of: scenePhase) { phase in
//                    if phase != .active {
//                        dataController.save()
//                    }
//                }
                .onChange(of: scenePhase) {
                    if scenePhase != .active {
                        dataController.save()
                    } else {
                        return
                    }
                }
        }
    }
}
