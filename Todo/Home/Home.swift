//
//  Home.swift
//  Todo
//
//  Created by Vinh Le on 2/19/21.
//

import SwiftUI

struct Home: View {
    let todos: [Todo]
    var primaryColor = Color(#colorLiteral(red: 0.06076231701, green: 0.3803908144, blue: 0.8452301824, alpha: 1))
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(todos, id: \.self) {todo in
                    HStack {
                        HStack {
                            Image(systemName: "circle")
                                .font(.system(size: 24, weight: .light))
                                .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                            VStack(alignment: .leading) {
                                Text(todo.title)
                                    .padding(.top, 12)
                                Divider()
                            }
                        }.padding(.bottom, 8)
                        Spacer()
                    }
                }
            }
            Spacer()
            HStack {
                HStack {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
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
}

let TODO_DATA: [Todo] = [
    .init(title: "Go to school"),
    .init(title: "Go to work"),
    .init(title: "Hit to gym"),
    .init(title: "Throw the trash"),
    .init(title: "Learn investment"),
    .init(title: "Buy groceries"),
]

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Home(todos: TODO_DATA).navigationBarTitle("Today")
        }
    }
}
