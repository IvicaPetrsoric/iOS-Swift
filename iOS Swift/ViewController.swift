//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var shouldRemember = false
    @State private var areTermsAccepted = false
    @State private var goToSecondView = false
    
    @FocusState private var focused: FocusedTextField?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 42) {
                HeaderView()
                InputView(
                    firstName: $firstName,
                    lastName: $lastName,
                    shouldRemember: $shouldRemember,
                    isFocused: $focused
                )
                Spacer()
                ToggleView(areTermsAccepted: $areTermsAccepted)
                LogginButton(areTermsAccepted: $areTermsAccepted)
            }
        }
        .padding(20)
        .preferredColorScheme(.dark)
    }
}


struct SecondScreen: View {
    var body: some View {
        VStack {
            Text("Radi")
            Text("Ignore dizajn")
                .foregroundColor(.red)
        }
        .navigationTitle("Laganica")
    }
}

// MARK: - Views -

// MARK: - Header View


struct HeaderView: View {
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 4) {
                UppercassedText(text: "Sunday, Apr 9")
                    .foregroundColor(.gray)
                
                Text("Welcome")
                    .font(.largeTitle)
            }
            
            Spacer()
            
            Image(.test1)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 48, height: 48)
        }
    }
}

struct UppercassedText: View {
    
    let text: String
    
    var body: some View {
        Text(text.uppercased())
    }
}

struct InputView: View {
    
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var shouldRemember: Bool
    @FocusState.Binding var isFocused: FocusedTextField?

    var body: some View {
        VStack(spacing: 16) {
            TextFieldView(
                text: $firstName,
                isFocused: $isFocused,
                title: "First name:",
                placeholder: "Lucija", 
                textFieldFocused: .firstName
            )
            .submitLabel(.next)
            .onAppear {
                isFocused = .firstName
            }
            .onSubmit {
                isFocused = .lastName
            }
            
            Divider()
            
            TextFieldView(
                text: $lastName,
                isFocused: $isFocused,
                title: "Last name:",
                placeholder: "Balja",
                textFieldFocused: .lastName
            )
            .submitLabel(.done)
            
            Divider()
            
            Toggle("Remember me", isOn: $shouldRemember)
        }
    }
}

struct TextFieldView: View {
    
    @Binding var text: String
    @FocusState.Binding var isFocused: FocusedTextField?
    
    let title: String
    let placeholder: String
    let textFieldFocused: FocusedTextField
    
    var body: some View {
        HStack(spacing: 10) {
            Text(title)
            Spacer()
            TextField(placeholder, text: $text)
                .multilineTextAlignment(.leading)
                .focused($isFocused, equals: textFieldFocused)
        }
    }
    
}

enum FocusedTextField: Hashable {
    case firstName
    case lastName
}

// MARK: - Toggle View

struct ToggleView: View {
    
    @Binding var areTermsAccepted: Bool
    
    var body: some View {
        Toggle(isOn: $areTermsAccepted) {
            Text("I accept terms and conditions")
            Spacer()
        }
        .toggleStyle(CheckboxStyle())
    }
}

struct CheckboxStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        return HStack(spacing: 0) {
            configuration.label
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .font(.system(size: 20, weight: .regular, design: .default))
        }
        .contentShape(Rectangle())
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}

// MARK: - Login button

struct LogginButton: View {

    @Binding var areTermsAccepted: Bool

    var body: some View {
        NavigationLink(destination: SecondScreen()) {
            HStack(spacing: 0) {
                Spacer(minLength: 4)
                
                Button("Tap me") {
                    print("Tapped")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)  
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .opacity(areTermsAccepted ? 1 : 0.7)
                .disabled(!areTermsAccepted)

                Spacer(minLength: 4)
            }
        }
        .disabled(!areTermsAccepted)
    }
}

struct GhostButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundStyle(.tint)
            .background(
                RoundedRectangle(
                    cornerRadius: 20,
                    style: .continuous
                )
                .stroke(.tint, lineWidth: 2)
            )
    }
}

extension ButtonStyle where Self == GhostButtonStyle {
    static var ghost: Self {
        return .init()
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .padding()
            .background(configuration.isPressed ? .blue.opacity(0.1) : .blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primaryButtonStyle: PrimaryButtonStyle { PrimaryButtonStyle() }
}


struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
