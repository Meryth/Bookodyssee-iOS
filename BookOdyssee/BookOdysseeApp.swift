//
//  BookOdysseeApp.swift
//  BookOdyssee
//
//  Created by Elna on 03.01.24.
//

import SwiftUI

@main
struct BookOdysseeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
