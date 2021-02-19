//
//  TodoApp.swift
//  Todo
//
//  Created by Vinh Le on 2/18/21.
//

import SwiftUI
import Firebase

@main
struct TodoApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
