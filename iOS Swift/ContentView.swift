//
//  ContentView.swift
//  StackingEssentials
//
//  Created by ivica petrsoric on 07/02/2020.
//  Copyright © 2020 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var firstName = ""
    @State var lastName = ""
    
    @State var users = [String]()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    VStack {
                        Group {
                            TextField("First Name", text: $firstName).padding(12)
                            }.background(Color.white).clipShape(RoundedRectangle(cornerRadius: 5)).shadow(radius: 5)
                        
                        Group {
                            TextField("Last Name", text: $lastName).padding(12)
                        }.background(Color.white).clipShape(RoundedRectangle(cornerRadius: 5)).shadow(radius: 5)

                        Button(action: {
                            self.users.append("\(self.firstName) \(self.lastName)")
                            self.firstName = ""
                            self.lastName = ""
                        }) {
                            Group {
                                Text("Createe User").foregroundColor(.white).padding(12)
                            }.background((firstName.count + lastName.count > 0) ? Color.blue : Color.gray).clipShape(RoundedRectangle(cornerRadius: 5)).shadow(radius: 5)
                        }
                    }.padding(12)
                }.background(Color.gray)
                
                List (users, id: \.self) { user in
                    Text(user)
                }
            }
            
            .navigationBarTitle("Credit Card From")
            .navigationBarItems(leading: HStack {
                Text("First name")
                Text(firstName).foregroundColor(.red)
                Text("Lirst name")
                Text(lastName).foregroundColor(.red)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
