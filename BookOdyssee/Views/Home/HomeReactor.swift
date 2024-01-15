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
                savedBooks.predicate = NSPredicate(format: "readingState == %@", ReadingState.toRead.description)
                
                state.toReadList = try moc.fetch(savedBooks)
                
            } catch {
                print("Error when fetching books!")
                print(error)
            }
        }
    }
    
}
