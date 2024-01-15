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
                List(reactor.toReadList, id: \.id) { book in
                    Section(header: Text(ReadingState.reading.description)) {
                    NavigationLink(destination: ReactorView(
                        BookReactor(dbContext: viewContext)
                    ) {
                        if let bookId = book.bookId {
                            BookView(bookId: bookId)
                        }
                    }) {
                        
                            if let title = book.title, let image = book.imageLink, let authors = book.authors {
                                BookDataRow(
                                    title: title,
                                    image: image,
                                    authors: authors
                                )
                            }
                        }
                    }
                }
                .task {
                    reactor.send(.loadBooks)
                }
                .navigationTitle("To Read")
            }.toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(
                        destination: ReactorView(SearchReactor()) {
                            SearchView()
                        }
                    ) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
