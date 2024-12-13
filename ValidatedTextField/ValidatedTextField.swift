//
//  ValidatedTextField.swift
//  Websites.co.in
//
//  Created by Ujjwal Arora on 13/12/24.
//

import SwiftUI

struct ValidatedTextField: View {
    enum FocusField{
        case username, password
    }
    @State var username: String = ""
    @State var password: String = ""
    @FocusState var focusField : FocusField?
    
    @State var errorMessages = [FocusField : String]()
    
    var body: some View {
        Form{
            VStack(alignment : .leading) {
                TextField("Username", text: $username)
                    .onChange(of: username, { _, _ in
                        validate(field: .username)
                    })
                    .focused($focusField, equals: .username)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(errorMessages[.username] == nil ? .clear : .red, lineWidth: 1)
                    }
                if let errorMessage = errorMessages[.username]{
                    Text(errorMessage)
                        .font(.footnote)
                }
            }
            VStack(alignment : .leading)  {
                SecureField("Password", text: $password)
                    .onChange(of: password, { _, _ in
                        validate(field: .password)
                    })
                    .focused($focusField, equals: .password)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(errorMessages[.password] == nil ? .clear : .red, lineWidth: 1)
                    }
                if let errorMessage = errorMessages[.password]{
                    Text(errorMessage)
                        .font(.footnote)
                }
            }
            Button("Submit"){
            }
            .disabled(isValid)
        }
        .onChange(of: focusField) { oldValue, _ in
            if let oldValue{
                validate(field: oldValue)
            }
        }
    }
    private func validate(field : FocusField){
        switch field {
        case .username:
            if username.isEmpty{
                errorMessages[.username] = "Username is required"
            }else{
                errorMessages.removeValue(forKey: .username)
            }
        case .password:
            if password.isEmpty{
                errorMessages[.password] = "Password is required"
            }else{
                errorMessages.removeValue(forKey: .password)
            }
        }
    }
    private var isValid : Bool{
        return !errorMessages.isEmpty
    }
}

#Preview {
    ValidatedTextField()
}
