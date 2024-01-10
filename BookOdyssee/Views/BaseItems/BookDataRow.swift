//
//  BookDataRow.swift
//  BookOdyssee
//
//  Created by Elna on 09.01.24.
//

import SwiftUI

struct BookDataRow: View {
    
    var bookId: String
    var title: String
    var authorList: [String]
    var imageUrl : String?
    
    var body: some View {
        HStack() {
            if let image = imageUrl {
                Image(image)
                    .resizable()
                    .frame(width: 64, height: 100)
                    .scaledToFit()
            }
            VStack() {
                Text(title).fontWeight(.bold)
                ForEach(authorList, id: \.self) { author in
                    Text(author)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    BookDataRow(
        bookId: "bookId",
        title: "Book",
        authorList: ["Author", "Bob"],
        imageUrl: "tempPlaceholder"
    )
}
