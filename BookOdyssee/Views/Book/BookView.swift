//
//  BookView.swift
//  BookOdyssee
//
//  Created by Elna on 05.01.24.
//

import SwiftUI
import AsyncReactor

struct BookView: View {
    
    @EnvironmentObject
    private var reactor : BookReactor
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if let book = reactor.book {
                
                Group {
                    Text(book.volumeInfo.title)
                        .font(.largeTitle)
                        .frame(alignment: .top)
                    
                    if let image = book.volumeInfo.imageLinks?.thumbnail {
                        AsyncImage(url: URL(string: image))
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 140)
                            .scaledToFit()
                    } else {
                        Image("NoImagePlaceholder")
                            .resizable()
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 140)
                            .scaledToFit()
                    }
                }.frame(
                    maxWidth: .infinity,
                    alignment: Alignment.center
                )
                
                
                Divider()
                    .padding()
                
                if let authors = book.volumeInfo.authors {
                    DataRow(
                        label: "Author",
                        value: getAuthorString(authorList: authors)
                    )
                }
                
                if let publisher = book.volumeInfo.publisher {
                    DataRow(label: "Publisher", value: publisher)
                }
                
                DataRow(label: "Published", value: book.volumeInfo.publishedDate)
                
                DataRow(label: "Page count:", value: String(book.volumeInfo.pageCount))
                
                Spacer()
                
                HStack() {
                    Button("Add to list", action: {
                        /*reactor.send(.onQueryChange(<#T##String#>))*/
                    })
                    .padding(15)
                    .frame(maxWidth: .infinity)
                    .background(Color("Primary"))
                    .foregroundColor(.white)
                    
                }.padding(.horizontal)
                
                Spacer()
            }
        }.task {
            reactor.send(.loadBookData)
        }
    }
}

func getAuthorString(authorList: [String]) -> String {
    var fullAuthorList = ""
    
    for author in authorList {
        if authorList.isEmpty {
            fullAuthorList.append(author)
        } else {
            fullAuthorList.append(", \(author)")
        }
    }
    
    return fullAuthorList
}

#Preview {
    BookView()
}
