//
//  GameEditor.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 09.11.2026..
//  Copyright © 2026 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct GameEditor: View {
    
    @Bindable var game: CodeBreaker
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Game Name", text: $game.name)
            }
            Section("Pegs") {
                PegChoicesChooser(pegChoices: $game.pegChoices)
            }
        }
    }
}

#Preview {
    @Previewable let game = CodeBreaker(name: "Preview", pegChoices: [.orange, .purple])
    GameEditor(game: game)
        .onChange(of: game.name) {
            print("game name changed to \(game.name) ")
        }
        .onChange(of: game.pegChoices) {
            print("game pegs changed to \(game.pegChoices)")
        }
}
