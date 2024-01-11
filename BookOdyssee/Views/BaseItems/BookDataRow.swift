//
//  BookDataRow.swift
//  BookOdyssee
//
//  Created by Elna on 09.01.24.
//

import SwiftUI

struct BookDataRow: View {
    
    var book : BookItem
    
    var body: some View {
        NavigationLink(value: book.self) {
            HStack {
                if let image = book.volumeInfo.imageLinks?.thumbnail {
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
                    Text(book.volumeInfo.title)
                        .fontWeight(.bold)
                    
                    if let authors = book.volumeInfo.authors {
                        ForEach(authors, id: \.self) { author in
                            Text(author)
                        }
                    }
                    
                }
                Spacer()
            }
        }
    }
}

#Preview {
    BookDataRow(
        book: BookItem(
            id: "bookId",
            volumeInfo: VolumeInfo(
                title: "title",
                publishedDate: "19.05.2023",
                pageCount: 500)
        )
    )
}
