//
//  BookReactor.swift
//  BookOdyssee
//
//  Created by Elna on 10.01.24.
//

import Foundation
import AsyncReactor
import CoreData

private let apiClient = ApiClient()

class BookReactor: AsyncReactor {    
    
    var moc: NSManagedObjectContext
    
    enum Action {
        case loadBookData(String)
        case addBookToReadingList
    }
    
    struct State {
        var book: BookItem? = nil
    }
    
    @Published
    private(set) var state: State
    
    @MainActor
    init(dbContext: NSManagedObjectContext, state: State = State()) {
        self.state = state
        self.moc = dbContext
    }
    
    func action(_ action: Action) async {
        switch action {
        case .loadBookData(let bookId):
            do {
                state.book = try await apiClient.getBookById(endpoint: .getBookById(id: bookId))
            } catch {
                print("Error when fetching book data!")
                print(error)
            }
        case .addBookToReadingList:
            do {
                let localBook = LocalBook(context: moc)
                
                localBook.bookId = state.book?.id
                localBook.title = state.book?.volumeInfo.title
                localBook.authors = state.book?.volumeInfo.authors?.first
                localBook.imageLink = state.book?.volumeInfo.imageLinks?.thumbnail
                localBook.publishedDate = state.book?.volumeInfo.publishedDate
                localBook.publisher = state.book?.volumeInfo.publisher
                localBook.readingState = "TO READ"
                
                try moc.save()
            } catch {
                print("Error while saving book to DB!")
                print(error)
            }
        }
    }
}
