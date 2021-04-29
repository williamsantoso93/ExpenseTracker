//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by William Santoso on 14/02/21.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TestSaveView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
