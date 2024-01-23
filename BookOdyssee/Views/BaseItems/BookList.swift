//
//  BookSection.swift
//  BookOdyssee
//
//  Created by Elna on 16.01.24.
//

import SwiftUI
import AsyncReactor

struct BookList: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var bookList : [LocalBook]
    
    var body: some View {
        ForEach(bookList, id: \.id) { book in
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
}
