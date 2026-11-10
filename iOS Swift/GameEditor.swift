//
//  GameEditor.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 09.11.2026..
//  Copyright © 2026 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct GameEditor: View {

    @Environment(\.dismiss) var dismiss
    @Bindable var game: CodeBreaker
    
    let onChoose: () -> Void
    
    @State private var showInvalidGameAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Game Name", text: $game.name)
                        .autocapitalization(.words)
                        .autocorrectionDisabled(false)
                        .onSubmit {
                            done()
                        }
                }
                Section("Pegs") {
                    PegChoicesChooser(pegChoices: $game.pegChoices)
                }
            }                .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        done()
                    }
                    .alert("Invalid Game", isPresented: $showInvalidGameAlert) {
                        Button("OK") {
                            showInvalidGameAlert = false
                        }
                    } message: {
                        Text("A game musy have a name and more than one unique peg.")
                    }
                }
            }
        }
    }
    
    func done() {
        if game.isValid {
            onChoose()
            dismiss()
        } else {
            showInvalidGameAlert = true
        }
    }
}

extension CodeBreaker {
    
    var isValid: Bool {
        !name.isEmpty && Set(pegChoices).count >= 2
    }
}

#Preview {
    @Previewable let game = CodeBreaker(name: "Preview", pegChoices: [.orange, .purple])
    GameEditor(game: game) {
        print("game name changed to \(game.name) ")
        print("game pegs changed to \(game.pegChoices)")
    }
}
