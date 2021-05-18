//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import SwiftUI
import Combine

// model
enum PasswordStatus {
    case empty
    case notStrongEnought
    case repeatedPasswordWrong
    case valid
}

class FormViewModel: ObservableObject {
    
    private var cancallables = Set<AnyCancellable>()
    
    @Published var username = ""
    @Published var pasword = ""
    @Published var passwordAgain = ""
    
    @Published var inlineErrorForPassword = ""

    @Published var isValid = false
    
    private static let predicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
    
    private var isUsernameValidPublisher: AnyPublisher<Bool, Never> {
        $username
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.count >= 3 }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $pasword
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    private var arePasswordsEqualPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($pasword, $passwordAgain)
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .map { $0 == $1 }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordStrongPublisher: AnyPublisher<Bool, Never> {
        $pasword
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {
//                $0.count > 6
                Self.predicate.evaluate(with: $0)
            }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordValidPublisher: AnyPublisher<PasswordStatus, Never> {
        Publishers.CombineLatest3(isPasswordEmptyPublisher, isPasswordStrongPublisher, arePasswordsEqualPublisher)
            .map {
                if $0 {
                    return PasswordStatus.empty
                }
                
                if !$1 {
                    return PasswordStatus.notStrongEnought
                }
                
                if !$2 {
                    return PasswordStatus.repeatedPasswordWrong
                }
                
                return PasswordStatus.valid
            }
            .eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isPasswordValidPublisher, isUsernameValidPublisher)
            .map { $0 == .valid && $1 }
            .eraseToAnyPublisher()
    }
    
    init() {
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancallables)
        
        isPasswordValidPublisher
            .dropFirst()
            .receive(on: RunLoop.main)
            .map { passwordStatus in
                switch passwordStatus {
                
                case .empty:
                    return "Password cannot be empty!"
                case .notStrongEnought:
                    return "Password is too weak!"
                case .repeatedPasswordWrong:
                    return "Passwords do not match"
                case .valid:
                    return ""
                }
            }
            .assign(to: \.inlineErrorForPassword, on: self)
            .store(in: &cancallables)
    }
    

}

struct StartView: View {
    
    @ObservedObject private var formViewModel = FormViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("USERNAME")) {
                        TextField("Username", text: $formViewModel.username)
                            .autocapitalization(.none)
                    }
                    Section(header: Text("PASSWORD"), footer: Text(formViewModel.inlineErrorForPassword)
                                .foregroundColor(.red)) {
                        SecureField("Password", text: $formViewModel.pasword)
                        SecureField("Password again", text: $formViewModel.passwordAgain)

                    }
                }
                Button(action: {}) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 60)
                        .overlay(Text("Continue")
                                    .foregroundColor(.white))
                }.padding().disabled(!formViewModel.isValid)
            

                   
            }

        }
    }
    
}




struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StartView()
        }
    }
}
