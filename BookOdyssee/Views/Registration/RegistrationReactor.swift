//
//  RegistrationReactor.swift
//  BookOdyssee
//
//  Created by Elna on 14.01.24.
//

import Foundation
import AsyncReactor
import CoreData

class RegistrationReactor: AsyncReactor {
    var moc: NSManagedObjectContext
    
    enum Action {
        case onRegisterClick
    }
    
    enum SyncAction {
        case setUsername(String)
        case setPassword(String)
        case setConfirmPassword(String)
    }
    
    struct State {
        var username: String = ""
        var password: String = ""
        var confirmPassword: String = ""
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
        case .setConfirmPassword(let confirmPassword):
            state.confirmPassword = confirmPassword
        }
    }
    
    func action(_ action: Action) async {
        switch action {
        case .onRegisterClick:
            let savedUsers : NSFetchRequest<LocalUser> = LocalUser.fetchRequest()
            
            savedUsers.predicate = NSPredicate(format: "username == %@", state.username)
            
            do {
                let users = try moc.fetch(savedUsers)
                
                if users.isEmpty {
                    convertUserInputToLocalUser(username: state.username, password: state.password)
                    try moc.save()
                    NotificationCenter.default.post(name: .DidLogin, object: nil)
                } else {
                    throw CoreException.UserAlreadyExistsError
                }
                
            } catch {
                print("Error when trying to save user to DB!")
                print(error)
            }
        }
    }
}

extension RegistrationReactor {
    func convertUserInputToLocalUser(username: String, password: String) {
        let localUser = LocalUser(context: moc)
        
        localUser.username = username
        localUser.password = password
    }
}
