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
        case removeBookFromReadingList
    }
    
    struct State {
        var book: BookItem? = nil
        var isBookSavedToRead: Bool = false
        var localBook: LocalBook? = nil
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
                
                let savedBooks : NSFetchRequest<LocalBook> = LocalBook.fetchRequest()
                if let bookId = state.book?.id {
                    savedBooks.predicate = NSPredicate(format: "bookId == %@", bookId)
                    let numberOfBooks = try moc.count(for: savedBooks)
                    
                    if numberOfBooks > 0 {
                        state.isBookSavedToRead = true
                    }
                }
            } catch {
                print("Error when fetching book data!")
                print(error)
            }
        case .addBookToReadingList:
            do {
                guard let bookItem = state.book else {
                    print("Book cannot be nil!")
                    throw CoreException.NilPointerError
                }
                
                convertBookItemToLocalBook(bookItem: bookItem)
                
                try moc.save()
                
                state.isBookSavedToRead = true
            } catch {
                print("Error while saving book to DB!")
                print(error)
            }
        case .removeBookFromReadingList:
            do {
                let savedBooks : NSFetchRequest<LocalBook> = LocalBook.fetchRequest()
                
                if let bookId = state.book?.id {
                    savedBooks.predicate = NSPredicate(format: "bookId == %@", bookId)
                    
                    do {
                        let objects = try moc.fetch(savedBooks).first
                        
                        if let localBook = objects {
                            moc.delete(localBook)
                            
                            do {
                                try moc.save()
                                state.isBookSavedToRead = false
                            } catch {
                                print("Error while deleting book from DB!")
                                print(error)
                                
                            }
                        }
                    } catch {
                        print("Unable to fetch saved books from DB!")
                        print(error)
                    }
                }
            }
        }
    }
}

extension BookReactor {
    func convertBookItemToLocalBook(bookItem: BookItem) -> LocalBook {
        let localBook = LocalBook(context: moc)
        
        localBook.bookId = bookItem.id
        localBook.title = bookItem.volumeInfo.title
        localBook.authors = bookItem.volumeInfo.authors
        localBook.imageLink = bookItem.volumeInfo.imageLinks?.thumbnail
        localBook.publishedDate = bookItem.volumeInfo.publishedDate
        localBook.publisher = bookItem.volumeInfo.publisher
        localBook.readingState = "TO READ"
        
        return localBook
    }
}
