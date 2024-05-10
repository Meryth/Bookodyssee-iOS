//
//  BookOdysseeApp.swift
//  BookOdyssee
//
//  Created by Elna on 22.04.24.
//

import SwiftUI

@main
struct BookOdysseeApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
