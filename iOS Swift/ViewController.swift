//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct StartView: View {
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var birthDate = Date()
    @State private var shouldSendNewsletter = false
    @State private var numberOfLikes = 1
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal information")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    DatePicker("Birthdate", selection: $birthDate, displayedComponents: .date)
                }
                
                if #available(iOS 14.0, *) {
                    Section(header: Text("Actions")) {
                        Toggle("Send Newsletter", isOn: $shouldSendNewsletter)
                            .toggleStyle(SwitchToggleStyle(tint: .red))
                        Stepper("Number of likes", value: $numberOfLikes, in: 1...100)
                        Text("This video has \(numberOfLikes) likes")
                        Link("Terms of service", destination: URL(string: "htpps://www.google.com")!)
                    }
                    
                    .accentColor(.red)
                    .navigationTitle("Account")
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button {
                                hideKeyboard()
                            } label: {
                                Image(systemName: "keyboard.chevron.compact.down")
                            }
                        }
                    }
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
    
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StartView()
        }
    }
}
