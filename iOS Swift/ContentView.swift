//
//  ContentView.swift
//  StackingEssentials
//
//  Created by ivica petrsoric on 07/02/2020.
//  Copyright © 2020 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct User: Identifiable {
    var id: Int
    
    let username, message: String
    var imageName: String?
}

struct ContentView: View {
    
    let users: [User] = [
        .init(id: 0, username: "Tim Cook", message: "My nice shiny new monitor stand is $999"),
        .init(id: 1, username: "Craig Federighi", message: "My nice shiny new monitor stand is $999"),
        .init(id: 2, username: "Jon Ivey", message: "My nice shiny new monitor stand is $999 My nice shiny new monitor stand is $999 My nice shiny new monitor stand is $999"),
    ]
    var body: some View {
        NavigationView {
//            List (users) {
            List {
                Text("Users").font(.largeTitle)
                ForEach(users, id: \.id) { user in
                    UserRow(user: user)
                }

//                Text($0.username)
            }.navigationBarTitle("Dynamic")
        }
    }
}

struct UserRow: View {
    let user: User
    
    var body: some View {
        HStack {
            Image("pingy")
                .resizable()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 4))
                .frame(width: 75, height: 75)
//                            .clipped()
            VStack (alignment: .leading) {
                Text(user.username).font(.headline)
                Text(user.message).font(.subheadline).lineLimit(nil)
            }.padding(.leading, 8)
        }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
