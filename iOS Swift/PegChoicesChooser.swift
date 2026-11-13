//
//  PegChoicesChooser.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 09.11.2026..
//  Copyright © 2026 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct PegChoicesChooser: View {
    
    @Binding var pegChoices: [Color]
    
    var body: some View {
        List {
            ForEach(pegChoices.indices, id: \.self) { index in
                ColorPicker(
                    selection: $pegChoices[index],
                    supportsOpacity: false
                ) {
                    button("Peg Choice \(index+1)", systemImage: "minus.circle", color: .red) {
                        pegChoices.remove(at: index)
                    }
                }
            }
            
            button("Add Peg", systemImage: "plus.circle", color: .green) {
                pegChoices.append(.green)
            }
        }
    }
    
    func button(
        _ title: String,
        systemImage: String,
        color: Color? = nil,
        action: @escaping () -> ()
    ) -> some View {
        HStack {
            Button {
                withAnimation {
                    action()
                }
            } label: {
                Image(systemName: systemImage).tint(color)
            }
            
            Text(title)
        }
    }
}

#Preview {
    @Previewable @State var pegChoices: [Color] = .init(repeating: .red, count: 4)
    PegChoicesChooser(pegChoices: $pegChoices)
        .onChange(of: pegChoices) {
            print("game pegs changed to \(pegChoices)")
        }
}
