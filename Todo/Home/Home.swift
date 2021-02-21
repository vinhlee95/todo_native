//
//  Home.swift
//  Todo
//
//  Created by Vinh Le on 2/19/21.
//

import SwiftUI

class TodoList: ObservableObject {
    @Published var todos: [Todo] = [
        .init(title: "Go to school", done: false),
        .init(title: "Go to work", done: false),
        .init(title: "Hit to gym", done: true),
        .init(title: "Throw the trash", done: true),
        .init(title: "Learn investment", done: false),
        .init(title: "Buy groceries", done: true),
    ]
}

struct Home: View {
    var primaryColor = Color(#colorLiteral(red: 0.06076231701, green: 0.3803908144, blue: 0.8452301824, alpha: 1))
    @State var newTodoTitle = ""
    @State var showNewTodoField = false
    @ObservedObject var vm = TodoList()
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(vm.todos, id: \.self) {todo in
                    HStack {
                        HStack {
                            Image(systemName: todo.done ? "largecircle.fill.circle" : "circle")
                                .font(.system(size: 24, weight: .light))
                                .foregroundColor(todo.done ? Color.red : Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                            VStack(alignment: .leading) {
                                Text(todo.title)
                                    .padding(.top, 12)
                                Divider()
                            }
                        }.padding(.bottom, 8)
                        Spacer()
                    }
                }
                if showNewTodoField {
                    HStack {
                        Image(systemName: "circle")
                            .font(.system(size: 24, weight: .light))
                            .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        CustomTextField(text: $newTodoTitle, nextResponder: .constant(nil), isResponder: $showNewTodoField, onEditingEnd: onTodoSubmit, isSecured: false, keyboard: .default)
                    }.padding(.bottom, 8)
                }
            }
            Spacer()
            HStack {
                HStack {
                    Button(action: {showNewTodoField = true}, label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(primaryColor)
                            .font(.system(size: 20))
                        Text("New Todo")
                            .foregroundColor(primaryColor)
                            .font(.system(size: 14, weight: .semibold))
                    })
                }
                Spacer()
            }
        }.padding(.horizontal)
    }
    
    func onTodoSubmit() {
        self.vm.todos.append(.init(title: newTodoTitle, done: false))
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Home().navigationBarTitle("Today")
        }
    }
}
