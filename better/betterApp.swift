//
//  betterApp.swift
//  better
//
//  Created by Dennis Collinson on 12/15/20.
//

import SwiftUI

@main
struct betterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
