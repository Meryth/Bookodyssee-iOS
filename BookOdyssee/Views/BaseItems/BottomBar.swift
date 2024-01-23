//
//  BottomBar.swift
//  BookOdyssee
//
//  Created by Elna on 16.01.24.
//

import SwiftUI
import AsyncReactor

struct BottomBar: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView {
            ReactorView(HomeReactor(moc: viewContext)) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "book")
                    }
            }
            ReactorView(FinishedReactor(moc: viewContext)) {
                FinishedView()
                    .tabItem{
                        Label("Finished", systemImage: "book.closed")
                    }
            }
        }
    }
}

#Preview {
    BottomBar()
}
