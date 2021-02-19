//
//  EmailPasswordSignIn.swift
//  Todo
//
//  Created by Vinh Le on 2/19/21.
//

import SwiftUI
import Firebase

struct EmailPasswordSignIn: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    let handleLoginSuccess: () -> Void
    
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

    
    var body: some View {
        VStack {
            VStack {
                TextField("Email", text: $email)
                    .onChange(of: email, perform: { (value) in
                        clearErrorMessage()
                    })
                    .padding(10)
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 8)
                SecureField("Password", text: $password)
                    .onChange(of: password, perform: { (value) in
                        clearErrorMessage()
                    })
                    .padding(10)
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 8)
                
                if errorMessage != "" {
                    Text(errorMessage).foregroundColor(Color.red)
                }
            }.padding(.horizontal).padding(.bottom, 8)
            
            Button(action: {login()}, label: {
                LoginButtonContent()
            }).padding(.bottom, 8)
        }
    }
    
    private func clearErrorMessage() {
        errorMessage = ""
    }
    
    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                errorMessage = error?.localizedDescription ?? ""
                return
            }
            
            let user = result?.user
            handleLoginSuccess()
            
        }
    }
}

struct LoginButtonContent : View {
    var body: some View {
        return Text("Sign in")
            .font(.headline)
            .foregroundColor(.white)
            .padding(8)
            .frame(width: 280, height: 45, alignment: .center)
            .background(Color.black)
            .cornerRadius(8)
    }
}

struct EmailPasswordSignIn_Previews: PreviewProvider {
    static var previews: some View {
        EmailPasswordSignIn(handleLoginSuccess: {})
    }
}
