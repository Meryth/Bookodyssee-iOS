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
                    NavigationLink(value: book.self) {
                        HStack {
                            if let image = book.imageLink {
                                AsyncImage(
                                    url: URL(string: image)
                                )
                                .frame(width: 64, height: 100)
                                .scaledToFit()
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
                                    Text(authors)
                                }
                            }
                            Spacer()
                        }
                    }.navigationDestination(for: LocalBook.self) { book in
                        if let bookId = book.bookId {
                            ReactorView(BookReactor()) {
                                BookView(bookId: bookId)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
