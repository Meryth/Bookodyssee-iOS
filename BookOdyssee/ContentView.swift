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
    
    var body: some View {
        HomeView()
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
