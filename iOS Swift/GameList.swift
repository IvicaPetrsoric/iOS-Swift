//
//  GameList.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 05.11.2026..
//  Copyright © 2026 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct GameList: View {
    
    @Binding var selection: CodeBreaker?
    
    @State private var games: [CodeBreaker] = []
    @State private var showGameEditor: Bool = false
    @State private var gameToEdit: CodeBreaker?

    var body: some View {
        List(selection: $selection) {
            ForEach(games) { game in
                NavigationLink(value: game) {
                    GameSummary(game: game)
                }
                .contextMenu {

                }
            }
            .onDelete { offsets in
                games.remove(atOffsets: offsets)
            }
            .onMove { offset, destination in
                games.move(fromOffsets: offset, toOffset: destination)
            }
        }
        .onChange(of: games) { _ in
            if let selection, !games.contains(selection) {
                self.selection = nil
            }
        }
        .listStyle(.plain)
        .toolbar {
            Button("Add Game", systemImage: "plus") {
                gameToEdit = CodeBreaker(name: "Untitlrd", pegChoices: [.red, .blue])
            }
            .onChange(of: gameToEdit) { _ in
                showGameEditor = gameToEdit != nil
            }
            .sheet(isPresented: $showGameEditor, onDismiss: {
                if let gameToEdit {
                    games.insert(gameToEdit, at: 0)
                }
                
                gameToEdit = nil
            }) {
                if let gameToEdit {
                    GameEditor(game: gameToEdit)
                }
            }
            
            EditButton()
        }
        .onAppear {
            addSampleGames()
        }
    }
    
    func deleteButton(for game: CodeBreaker) -> some View {
        Button("Delete", systemImage: "minus.circle", role: .destructive) {
            withAnimation {
                games.removeAll(where: { $0 == game })
            }
        }
    }
    
    func addSampleGames() {
        if games.isEmpty {
            games.append(CodeBreaker(name: "Mastermind", pegChoices: [.red, .blue, .green, .yellow]))
            games.append(CodeBreaker(name: "Earth Tones", pegChoices: [.orange, .brown, .black, .yellow, .green]))
            games.append(CodeBreaker(name: "Undersea", pegChoices: [.blue, .indigo, .cyan]))
            selection = games[Int.random(in: 0..<games.count)]
        }
    }
}

//#Preview {
//    GameList()
//}
