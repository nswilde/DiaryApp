//
//  IssueViewToolbar.swift
//  Diary
//
//  Created by Nikki Wilde on 21/02/24.
//

import CoreHaptics
import SwiftUI

struct IssueViewToolbar: View {
    @EnvironmentObject var dataController: DataController
    @StateObject var issue: Issue

    @State private var engine = try? CHHapticEngine()

    var openCloseButtonText: LocalizedStringKey {
        issue.completed ? "Remove favorite" : "Mark as favorite"
    }

    var body: some View {
            Menu {
                Button {
                    UIPasteboard.general.string = issue.title
                } label: {
                    Label("Copy Title", systemImage: "doc.on.doc")
                }
                Button(action: toggleCompleted) {
                    Label(
                        openCloseButtonText,
                        systemImage: "bubble.left.and.exclamationmark.bubble.right"
                    )
                }
                .sensoryFeedback(trigger: issue.completed) { _, newValue in
                    if newValue {
                        .success
                    } else {
                        nil
                    }
                }

                Divider()

                Section("Tags") {
                    TagsMenuView(issue: issue)
                }
            } label: {
                Label("Actions", systemImage: "ellipsis.circle")
            }
    }

    func toggleCompleted() {
        issue.completed.toggle()
        dataController.save()

        if issue.completed {
            do {
                try engine?.start()

                let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0)
                let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)

                let start = CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: 1)
                let end = CHHapticParameterCurve.ControlPoint(relativeTime: 1, value: 0)

                let parameter = CHHapticParameterCurve(
                    parameterID: .hapticIntensityControl,
                    controlPoints: [start, end],
                    relativeTime: 0
                )

                let event1 = CHHapticEvent(
                    eventType: .hapticTransient,
                    parameters: [intensity, sharpness],
                    relativeTime: 0
                )

                let event2 = CHHapticEvent(
                    eventType: .hapticContinuous,
                    parameters: [sharpness, intensity],
                    relativeTime: 0.125,
                    duration: 1
                )

                let pattern = try CHHapticPattern(events: [event1, event2], parameterCurves: [parameter])
                let player = try engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch {
                // playing haptics did not work
            }
        }
    }
}

#Preview {
    IssueViewToolbar(issue: Issue.example)
}
