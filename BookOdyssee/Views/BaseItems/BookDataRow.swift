//
//  BookDataRow.swift
//  BookOdyssee
//
//  Created by Elna on 09.01.24.
//

import SwiftUI

struct BookDataRow: View {
    
    var title: String
    var image: String?
    var authors: [String]?
    
    var body: some View {
        HStack {
            if let image = image {
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
                Text(title)
                    .fontWeight(.bold)
                
                if let authorList = authors {
                    ForEach(authorList, id: \.self) { author in
                        Text(author)
                    }
                }
                
            }
            Spacer()
        }
    }
}

#Preview {
    BookDataRow(
        title: "title",
        image: "image",
        authors: ["authors"]
    )
}
