//
//  LoginReactor.swift
//  BookOdyssee
//
//  Created by Elna on 14.01.24.
//

import Foundation
import AsyncReactor
import CoreData

public extension Notification.Name {
  static let DidLogin = Notification.Name("login")
}

class LoginReactor: AsyncReactor {
    var moc: NSManagedObjectContext
    let defaults = UserDefaults.standard
    
    enum Action {
        case onLoginClick
    }
    
    enum SyncAction {
        case setUsername(String)
        case setPassword(String)
    }
    
    struct State {
        var username: String = ""
        var password: String = ""
        var shouldNavigate: Bool = false
    }
    
    @Published
    private(set) var state: State
    
    @MainActor
    init(moc: NSManagedObjectContext, state: State = State()) {
        self.moc = moc
        self.state = state
    }
    
    func action(_ action: SyncAction) {
        switch action {
        case .setUsername(let username):
            state.username = username
        case .setPassword(let password):
            state.password = password
        }
    }
    
    func action(_ action: Action) async {
        switch action {
        case .onLoginClick:
            let savedUsers: NSFetchRequest<LocalUser> = LocalUser.fetchRequest()
            
            savedUsers.predicate = NSPredicate(format: "username == %@ AND password == %@", state.username, state.password)
            
            do {
                let users = try moc.fetch(savedUsers)
                
                if users.isEmpty {
                    throw CoreException.InvalidCredentialsError
                } else {
                    if let userId = users.first?.userId {
                        defaults.set(userId, forKey: "UserId")
                    }
                    NotificationCenter.default.post(name: .DidLogin, object: nil)
                }
            } catch {
                print("Invalid credentials!")
                print(error)
            }
        }
    }
}
