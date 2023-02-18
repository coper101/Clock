//
//  ClockApp.swift
//  Clock
//
//  Created by Wind Versi on 18/2/23.
//

import SwiftUI

@main
struct ClockApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
