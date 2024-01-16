//
//  FinishedReactor.swift
//  BookOdyssee
//
//  Created by Elna on 16.01.24.
//

import Foundation
import AsyncReactor
import CoreData

class FinishedReactor: AsyncReactor {
    
    var moc: NSManagedObjectContext
    
    enum Action {
        case loadBooks
    }
    
    struct State {
        var finishedList: [LocalBook] = []
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
                savedBooks.predicate = NSPredicate(format: "readingState == %@", ReadingState.finished.description)
                let bookList = try moc.fetch(savedBooks)
                
                state.finishedList = bookList
            } catch {
                print("Error when fetching books!")
                print(error)
            }
        }
    }
}
