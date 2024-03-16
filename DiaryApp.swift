//
//  DiaryApp.swift
//  Diary
//
//  Created by Nikki Wilde on 22/01/24.
//

import CoreSpotlight
import SwiftUI

@main
struct DiaryApp: App {
    @StateObject var dataController = DataController()
    @Environment(\.scenePhase) var scenePhase

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
                NavigationSplitView {
                    SidebarView(dataController: dataController)
                } content: {
                    ContentView(dataController: dataController)
                } detail: {
                    DetailView()
                }
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .onChange(of: scenePhase) {
                    if scenePhase != .active {
                        dataController.save()
                    } else {
                        return
                    }
                }
                .onContinueUserActivity(CSSearchableItemActionType, perform: loadSpotlightItem)
                }
            }

    // Spotlight part 3/3: Function that allows us to respond to Spotlight
    // Search at app launch. "onContinueUserActivity" extension above
    // utilizes this function.
    func loadSpotlightItem(_ userActivity: NSUserActivity) {
        if let uniqueIdentifier = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String {
            dataController.selectedIssue = dataController.issue(with: uniqueIdentifier)
            dataController.selectedFilter = .all
        }
    }
}
