//
//  HomeView.swift
//  BookOdyssee
//
//  Created by Elna on 05.01.24.
//

import SwiftUI
import AsyncReactor

struct HomeView: View {
    
    @EnvironmentObject
    private var reactor : HomeReactor
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section(
                        header: Text("Currently reading")
                            .foregroundStyle(Color("Primary"))
                    ) {
                        BookList(bookList: reactor.currentlyReadingList)
                    }
                    
                    Section(
                        header: Text("Want to read")
                            .foregroundStyle(Color("Primary"))
                    ) {
                        BookList(bookList: reactor.toReadList)
                    }
                    
                }
                
            }.task {
                reactor.send(.loadBooks)
            }
            .navigationTitle("To Read")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(
                        destination: ReactorView(SearchReactor()) {
                            SearchView()
                        }
                    ) {
                        Image(systemName: "plus")
                            .renderingMode(.template)
                            .foregroundColor(Color("Primary"))
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
