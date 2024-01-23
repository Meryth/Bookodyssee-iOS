//
//  HomeReactor.swift
//  BookOdyssee
//
//  Created by Elna on 15.01.24.
//

import Foundation
import AsyncReactor
import CoreData

class HomeReactor: AsyncReactor {
    
    var moc: NSManagedObjectContext
    let defaults = UserDefaults.standard
    
    enum Action {
        case loadBooks
    }
    
    struct State {
        var toReadList: [LocalBook] = []
        var currentlyReadingList: [LocalBook] = []
    }
    
    @Published
    private(set) var state: State
    
    @MainActor
    init(moc: NSManagedObjectContext, state: State = State()) {
        self.moc = moc
        self.state = state
    }
    
    func action(_ action: Action) async {
        switch action {
        case .loadBooks:
            do {
                let savedBooks : NSFetchRequest<LocalBook> = LocalBook.fetchRequest()
                guard let userId = defaults.string(forKey: "UserId") else {
                    throw CoreException.NilPointerError
                }
                savedBooks.predicate = NSPredicate(format: "userId == %@", userId)
                let bookList = try moc.fetch(savedBooks)
                
                state.currentlyReadingList = bookList.filter { book in
                   return book.readingState == ReadingState.reading.description
                }
                
                state.toReadList = bookList.filter {book in
                    return book.readingState == ReadingState.toRead.description
                }
                
            } catch {
                print("Error when fetching books!")
                print(error)
            }
        }
    }
    
}
