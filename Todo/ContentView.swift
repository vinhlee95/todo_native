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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
