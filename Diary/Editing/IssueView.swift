//
//  IssueView.swift
//  Diary
//
//  Created by Nikki Wilde on 31/01/24.
//

import SwiftUI

struct IssueView: View {
    @EnvironmentObject var dataController: DataController
    @StateObject var issue: Issue

    @State private var showingNotificationsError = false
    @Environment(\.openURL) var openURL

    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    TextField("Title", text: $issue.issueTitle, prompt: Text("Enter the entry title here"))
                        .font(.title)

                    Text("This Entry's score is: \(issue.score)/100")

                    Text("**Modified:** \(issue.issueModificationDate.formatted(date: .long, time: .shortened))")
                        .foregroundStyle(.secondary)

                    HStack {
                        Text("\(issue.issueStatus)")
                            .foregroundStyle(.secondary)
                        if issue.issueStatus == "Favorite" {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                        }
                    }
                }

                Picker("Priority", selection: $issue.priority) {
                    Text("Low").tag(Int16(0))
                    Text("Medium").tag(Int16(1))
                    Text("High").tag(Int16(2))
                }

                TagsMenuView(issue: issue)
            }

            Section {
                VStack(alignment: .leading) {
                    Text("Entry contents")
                        .font(.title2)
                        .foregroundStyle(.secondary)

                    TextField("Description",
                              text: $issue.issueContent,
                              prompt: Text("Describe how you're feeling."),
                              axis: .vertical
                    )
                }
            }

            Section("Reminders") {
                Toggle("Show reminders", isOn: $issue.reminderEnabled.animation())

                if issue.reminderEnabled {
                    DatePicker(
                        "Reminder time",
                        selection: $issue.issueReminderTime,
                        displayedComponents: .hourAndMinute
                    )
                }
            }
        }
        .disabled(issue.isDeleted)
        .onReceive(issue.objectWillChange) { _ in
            dataController.queueSave()
        }
        .onSubmit(dataController.save)
        .toolbar {
            IssueViewToolbar(issue: issue)
        }
        .alert("Oops!", isPresented: $showingNotificationsError) {
            Button("Check Settings", action: showAppSettings)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("There was a problem setting your notification, Please check you have notifications enabled.")
        }
        .onChange(of: issue.reminderEnabled) { _ in
            updateReminder()
        }
        .onChange(of: issue.reminderTime) { _ in
            updateReminder()
        }
    }

    func showAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openNotificationSettingsURLString) else {
            return
        }

        openURL(settingsURL)
    }

    func updateReminder() {
        dataController.removeReminders(for: issue)

        Task { @MainActor in
            if issue.reminderEnabled {
                let success = await dataController.addReminder(for: issue)

                if success == false {
                    issue.reminderEnabled = false
                    showingNotificationsError = true
                }
            }
        }
    }
}

#Preview {
    IssueView(issue: .example)
}
