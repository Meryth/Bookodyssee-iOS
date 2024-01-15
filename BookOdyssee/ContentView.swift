//
//  ContentView.swift
//  BookOdyssee
//
//  Created by Elna on 03.01.24.
//

import SwiftUI
import CoreData
import AsyncReactor

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State
    private var didLogin = false
    
    // TODO: refactor navigation logic to use navigationDestination
    var body: some View {
        ZStack {
            if !didLogin {
                ReactorView(HomeReactor(moc: viewContext)) {
                    HomeView()
                }
            } else {
                StartView()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .DidLogin)) { _ in
            didLogin = true
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
