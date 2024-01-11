//
//  BookReactor.swift
//  BookOdyssee
//
//  Created by Elna on 10.01.24.
//

import Foundation
import AsyncReactor

private let apiClient = ApiClient()

class BookReactor: AsyncReactor {
    enum Action {
        case loadBookData(String)
    }
    
    struct State {
        var book: BookItem? = nil
    }
    
    @Published
    private(set) var state: State
    
    @MainActor
    init(state: State = State()) {
        self.state = state
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
        }
    }
}
