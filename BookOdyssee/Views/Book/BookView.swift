//
//  BookView.swift
//  BookOdyssee
//
//  Created by Elna on 05.01.24.
//

import SwiftUI

struct BookView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Title")
                    .font(.largeTitle)
                    .frame(alignment: .top)
                
                Image("tempPlaceholder")
                    .resizable()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 140)
                    .scaledToFit()
            }.frame(
                maxWidth: .infinity,
                alignment: Alignment.center
            )
            
            
            Divider()
                .padding()
            
            DataRow(label: "Author", value: "John Doe")
            DataRow(label: "Author", value: "John Doe")
            
            Spacer()
            
            HStack() {
                Button("Add to list", action: {})
                    .padding(15)
                    .frame(maxWidth: .infinity)
                    .background(Color("Primary"))
                    .foregroundColor(.white)
            }.padding(.horizontal)
            
            Spacer()
            
        }
    }
}

#Preview {
    BookView()
}
