//
//  RoundedTextField.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import SwiftUI

struct RoundedTextField: View {

    @Binding var text: String
    var placeholder: String
    var isSecure: Bool = false

    var body: some View {
        if isSecure {
            SecureField(placeholder, text: $text)
                .padding()
                .background(.white)
                .cornerRadius(12)
                .shadow(radius: 1)
        } else {
            TextField(placeholder, text: $text)
                .padding()
                .background(.white)
                .cornerRadius(12)
                .shadow(radius: 1)
        }
    }
}

#Preview {
    RoundedTextField(text: .constant("test"), placeholder: "Test", isSecure: false)
}
