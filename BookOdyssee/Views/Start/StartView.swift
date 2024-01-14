//
//  StartView.swift
//  BookOdyssee
//
//  Created by Elna on 13.01.24.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        VStack() {
            Text("Welcome to\nBookOdyssee!")
                .font(.largeTitle)
                .foregroundStyle(Color("Secondary"))
                .padding(.bottom)
                .multilineTextAlignment(.center)
            
            
            Image("Logo")
                .resizable()
                .frame(width: 250, height: 130)
                .scaledToFit()
                .padding()
            
            Text("Your pocket library to go")
                .font(.caption)
                .foregroundStyle(Color("Secondary"))
            
            
            Group{
                Button(action: {
                    
                }) {
                    Text("Login")
                        .padding(15)
                        .frame(maxWidth: .infinity)
                        .background(Color("Primary"))
                        .foregroundColor(.white)
                }
            }.padding(.vertical)
            
            
            Button( action: {
                
            }) {
                Text("Register")
                    .padding(15)
                    .frame(maxWidth: .infinity)
                    .background(Color("Primary"))
                    .foregroundColor(.white)
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
}

#Preview {
    StartView()
}
