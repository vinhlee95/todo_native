//
//  ContentView.swift
//  Todo
//
//  Created by Vinh Le on 2/18/21.
//

import SwiftUI
import Firebase


struct ContentView: View {
    @State var loginSuccess = false
    
    var body: some View {
        NavigationView {
            VStack {
                EmailPasswordSignIn(handleLoginSuccess: handleLoginSuccess)
                AppleSignIn(handleLoginSuccess: handleLoginSuccess)
                NavigationLink(destination: Home().navigationBarBackButtonHidden(true), isActive: $loginSuccess) {
                    EmptyView()
                }.hidden()
            }
        }
    }
    
    private func handleLoginSuccess() {
        loginSuccess = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
