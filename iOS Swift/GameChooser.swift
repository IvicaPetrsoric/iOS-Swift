//
//  GameChooser.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 02.11.2026..
//  Copyright © 2026 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct GameChooser: View {
    
    // MARK: Data owned by me
    @State private var selection: CodeBreaker? = nil
        
    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
            GameList(selection: $selection)
            .navigationTitle("CodeBreaker")

        }  detail: {
            if let selection = selection {
                CodeBreakerView(game: selection)
                    .navigationTitle(selection.name)
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                Text("Choose a game")
            }
        }
        .navigationSplitViewStyle(.balanced)

    }
}

#Preview {
    GameChooser()
}
