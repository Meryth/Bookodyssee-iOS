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
                let readingList = try moc.fetch(savedBooks)
                
                state.currentlyReadingList = readingList.filter { book in
                   return book.readingState == ReadingState.reading.description
                }
                
                state.toReadList = readingList.filter {book in
                    return book.readingState == ReadingState.toRead.description
                }
                
            } catch {
                print("Error when fetching books!")
                print(error)
            }
        }
    }
    
}
