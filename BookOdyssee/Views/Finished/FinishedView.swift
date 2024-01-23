//
//  FinishedView.swift
//  BookOdyssee
//
//  Created by Elna on 16.01.24.
//

import SwiftUI
import AsyncReactor

struct FinishedView: View {
    
    @EnvironmentObject
    private var reactor: FinishedReactor
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationStack {
            VStack{
                List {
                    BookList(bookList: reactor.finishedList)
                }
            }.task {
                reactor.send(.loadBooks)
            }
            .navigationTitle("Finished")
        }
    }
}

#Preview {
    FinishedView()
}
