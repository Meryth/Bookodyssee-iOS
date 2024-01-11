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
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                if reactor.searchResult.isEmpty {
                    Text("No result!")
                } else {
                    List(reactor.searchResult, id: \.id) { book in
                        BookDataRow(
                            book: book
                        )
                    }
                }
            }
            .navigationTitle("Search")
            .navigationDestination(for: BookItem.self) { book in
                ReactorView(BookReactor()) {
                    BookView(bookId: book.id)
                }
            }
        }
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

#Preview {
    ReactorView(SearchReactor()) {
        SearchView()
    }
}
