//
//  RegistrationView.swift
//  BookOdyssee
//
//  Created by Elna on 14.01.24.
//

import SwiftUI
import AsyncReactor

struct RegistrationView: View {
    
    @EnvironmentObject
    private var reactor: RegistrationReactor
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack(alignment: .center) {
            TextField(
                "Username",
                text: Binding(
                    get: {reactor.username},
                    set: {reactor.action(.setUsername($0))}
                )
            )
            .padding(.bottom)
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            
            
            SecureField(
                "Password",
                text: Binding(
                    get: {reactor.password},
                    set: {reactor.action(.setPassword($0))}
                )
            )
            .padding(.bottom)
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            
            SecureField(
                "Confirm Password",
                text: Binding(
                    get: {reactor.confirmPassword},
                    set: {reactor.action(.setConfirmPassword($0))}
                )
            )
            .padding(.bottom)
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            
            Button(action: {
                reactor.send(.onRegisterClick)
            }) {
                Text("Register")
                    .padding(15)
                    .frame(maxWidth: .infinity)
                    .background(Color("Primary"))
                    .foregroundColor(.white)
            }
        }.padding(.horizontal)
    }
}
