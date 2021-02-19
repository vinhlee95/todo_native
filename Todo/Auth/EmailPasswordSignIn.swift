//
//  EmailPasswordSignIn.swift
//  Todo
//
//  Created by Vinh Le on 2/19/21.
//

import SwiftUI
import Firebase

struct EmailPasswordSignIn: View {
    @State var email = ""
    @State var password = ""
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

    
    var body: some View {
        VStack {
            VStack {
                TextField("Email", text: $email)
                    .padding(10)
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 8)
                SecureField("Password", text: $password)
                    .padding(10)
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 8)
            }.padding(.horizontal)
            
            Button(action: {login()}, label: {
                LoginButtonContent()
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
            print("Login success", user?.uid)
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
        EmailPasswordSignIn()
    }
}
