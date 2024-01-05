//
//  DataRow.swift
//  BookOdyssee
//
//  Created by Elna on 05.01.24.
//

import SwiftUI

struct DataRow: View {
    
    var label: String
    var value: String
    
    var body: some View {
        HStack() {
            Text(label)
            Spacer()
            Text(value)
        }.padding([.horizontal, .bottom])
    }
}

#Preview {
    DataRow(
        label: "Author",
        value: "John Doe"
    )
}
