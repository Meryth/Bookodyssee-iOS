//
//  HomeView.swift
//  BookOdyssee
//
//  Created by Elna on 05.01.24.
//

import SwiftUI
import AsyncReactor

struct HomeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<LocalBook>
    
    
    var body: some View {
        NavigationStack {
            VStack {
                List(books, id: \.id) { book in
                    NavigationLink(destination: ReactorView(
                        BookReactor(dbContext: viewContext)
                    ) {
                        if let bookId = book.bookId {
                            BookView(bookId: bookId)
                        }
                    }) {
                        HStack {
                            if let image = book.imageLink {
                                AsyncImage(
                                    url: URL(string: image),
                                    content: {image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 64, height: 100)
                                    },
                                    placeholder: {
                                       ProgressView()
                                    }
                                )
                            } else {
                                Image("NoImagePlaceholder")
                                    .resizable()
                                    .frame(width: 64, height: 100)
                                    .scaledToFit()
                            }
                            VStack(alignment: .leading) {
                                if let title = book.title {
                                    Text(title)
                                        .fontWeight(.bold)
                                }
                                if let authors = book.authors {
                                    Text(getAuthorString(authorList:authors))
                                }
                            }
                            Spacer()
                        }
                    }
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
