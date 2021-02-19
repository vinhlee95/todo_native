//
//  ContentView.swift
//  Todo
//
//  Created by Vinh Le on 2/18/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    var body: some View {
        VStack {
            EmailPasswordSignIn()
            AppleSignIn(handleLoginSuccess: {})
        }
    }
}

struct EmailPasswordSignIn: View {
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
            TextField("Password", text: $password)
            Button(action: {login()}, label: {
                Text("Sign In")
            })
        }
    }
    
    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            
            let user = result?.user
            print("Login success", user?.uid    )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
