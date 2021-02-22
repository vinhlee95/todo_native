//
//  Home.swift
//  Todo
//
//  Created by Vinh Le on 2/19/21.
//

import SwiftUI

class TodoViewModel: ObservableObject {
    @Published var todos: [Todo] = [
        .init(id: NSUUID().uuidString, title: "Go to school", done: false),
        .init(id: NSUUID().uuidString, title: "Go to work", done: false),
        .init(id: NSUUID().uuidString, title: "Hit to gym", done: true),
        .init(id: NSUUID().uuidString, title: "Throw the trash", done: true),
        .init(id: NSUUID().uuidString, title: "Learn investment", done: false),
        .init(id: NSUUID().uuidString, title: "Buy groceries", done: true),
    ]
}

struct TodoList: View {
    var primaryColor = Color(#colorLiteral(red: 0.06076231701, green: 0.3803908144, blue: 0.8452301824, alpha: 1))
    @State var newTodoTitle = ""
    @State var showNewTodoField = false
    @ObservedObject var vm = TodoViewModel()
    
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(getRenderedTodos(todos: vm.todos), id: \.self) {todo in
                    HStack {
                        TodoItem(todo: todo, toggleComplete: toggleComplete)
                        Spacer()
                    }.padding(.leading)
                }
                if showNewTodoField {
                    HStack {
                        Image(systemName: "circle")
                            .font(.system(size: 24, weight: .light))
                            .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        VStack(alignment: .leading) {
                            CustomTextField(text: $newTodoTitle, nextResponder: .constant(nil), isResponder: $showNewTodoField, onEditingEnd: onTodoSubmit, isSecured: false, keyboard: .default).padding(.bottom, 2)
                            Divider()
                        }
                    }.padding(.bottom, 8).padding(.leading)
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
            }.padding(.leading)
        }
    }
    
    private func onTodoSubmit() {
        self.vm.todos.append(.init(id: NSUUID().uuidString, title: newTodoTitle, done: false))
    }
    
    private func toggleComplete(id: String) {
        self.vm.todos = self.vm.todos.map({ (todo) -> Todo in
            let toggledDone = todo.id == id ? !todo.done : todo.done
            return Todo(id: todo.id, title: todo.title, done: toggledDone)
        })
    }
    
    // Categorise rendering todos so that incomplete ones are displayed first
    private func getRenderedTodos(todos: [Todo]) -> [Todo] {
        let completedTodos = todos.filter { (todo) -> Bool in
            return todo.done
        }
        let inCompleteTodos = todos.filter { (todo) -> Bool in
            return !todo.done
        }
        return inCompleteTodos + completedTodos
    }
}

struct TodoItem: View {
    let todo: Todo
    let toggleComplete: (_ id: String) -> Void
    
    var body: some View {
        HStack {
            Button(action: {toggleComplete(todo.id)}, label: {
                Image(systemName: todo.done ? "largecircle.fill.circle" : "circle")
                    .font(.system(size: 24, weight: .light))
                    .foregroundColor(todo.done ? Color.red : Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
            })
            VStack(alignment: .leading) {
                Text(todo.title).padding(.top, 12)
                Divider()
            }
        }.padding(.bottom, 8)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TodoList().navigationBarTitle("Today")
        }
    }
}
