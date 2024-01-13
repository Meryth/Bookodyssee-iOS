//
//  SearchView.swift
//  BookOdyssee
//
//  Created by Elna on 09.01.24.
//

import SwiftUI
import AsyncReactor

struct SearchView: View {
    
    @EnvironmentObject
    private var reactor: SearchReactor
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                if reactor.searchResult.isEmpty {
                    Text("No result!")
                } else {
                    List(reactor.searchResult, id: \.id) { book in
                        NavigationLink(destination: ReactorView(
                            BookReactor(dbContext: viewContext)
                        ) {
                            BookView(bookId: book.id)
                        }) {
                            BookDataRow(book: book)
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(
                text: Binding(
                    get: {reactor.query},
                    set: {reactor.action(.onQueryChange($0))}
                ),
                prompt: "Enter title, author...")
            .onSubmit(of: .search) {
                reactor.send(.onSearchClick)
            }
        }
    }
}

#Preview {
    ReactorView(SearchReactor()) {
        SearchView()
    }
}
