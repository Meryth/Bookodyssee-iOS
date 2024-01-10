//
//  HomeReactor.swift
//  BookOdyssee
//
//  Created by Elna on 09.01.24.
//

import Foundation
import AsyncReactor

private let apiClient = ApiClient()

class SearchReactor: AsyncReactor {
    enum Action {
        case onSearchClick
    }
    
    enum SyncAction {
        case onQueryChange(String)
    }
    
    struct State {
        var query: String = ""
        var searchResult: [BookItem] = []
    }
    
    //creates observable objects that announcce when changes occur (so like a StateFlow from Android)
    @Published
    private(set) var state: State
    
    //MainActor -> singleton, provides executor which performs its task on the main thread (important for UI updating tasks)
    // comparable to Android Controller's initialState()
    @MainActor
    init(state: State = State()) {
        self.state = state
    }
    
    func action(_ action: SyncAction) {
        switch action {
        case .onQueryChange(let query):
            state.query = query
        }
    }
    
    func action(_ action: Action) async {
        switch action {
        case .onSearchClick:
            if(state.query.isEmpty) {
                print("query is empty!")
                return
            }
            
            do {
                state.searchResult = try await apiClient.getBooksBySearchTerm(endpoint: .searchBooks(query: state.query)).items
            } catch {
                print("Error when fetching books!")
            }
        }
    }
}
