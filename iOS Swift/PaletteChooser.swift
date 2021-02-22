//
//  PaletteChooser.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 22/02/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct PaletteChooser: View {
    
    @ObservedObject var document: EmojiArtDocument
    @Binding var chosenPalette: String
    @State private var showPaletteEditor = false
    
    var body: some View {
        HStack {
            Stepper(onIncrement: {
                self.chosenPalette = self.document.palette(after: self.chosenPalette)
            }, onDecrement: {
                self.chosenPalette = self.document.palette(before: self.chosenPalette)

            }, label: { EmptyView() })
            Text(self.document.paletteNames[self.chosenPalette] ?? "")
            Image(systemName: "keyboard").imageScale(.large)
                .onTapGesture {
                    showPaletteEditor.toggle()
                }
                .sheet(isPresented: $showPaletteEditor) {
                    PaletteEditor(chosenPalette: $chosenPalette, isShown: $showPaletteEditor)
                        .environmentObject(self.document)
                        .frame(minWidth: 300, minHeight: 500)
                }
        }
        .fixedSize(horizontal: true, vertical: false)
    }
    
}

struct PaletteEditor: View {
    
    @EnvironmentObject var document: EmojiArtDocument
    
    @Binding var chosenPalette: String
    @Binding var isShown: Bool


    @State private var paletteName: String = ""
    @State private var emojistToAdd: String = ""
    
    var body: some View {
        VStack {
            ZStack {
                Text("Paletter Editor").font(.headline).padding()

                HStack {
                    Spacer()
                    Button {
                        isShown.toggle()
                    } label: {
                        Text("Done")
                    }.padding()

                }
            }
            Divider()
            Form {
                Section(header: Text("Palette Name")) {
                    TextField("Palette Name", text: $paletteName, onEditingChanged: { began in
                        if !began {
                            self.document.renamePalette(self.chosenPalette, to: self.paletteName)
                        }
                    })
                }
                
                Section(header: Text("Emoji Name")) {
                    TextField("Palette Name", text: $emojistToAdd, onEditingChanged: { began in
                        if !began {
                            self.chosenPalette = self.document.addEmoji(self.emojistToAdd, toPalette: chosenPalette)
                            self.emojistToAdd = ""
                        }
                    })
                }
                
                Section(header: Text("Remove Emoji")) {
                    Grid(chosenPalette.map { String($0) }, id: \.self) { emoji in
                        Text(emoji).font(Font.system(size: self.fontSize))
                            .onTapGesture {
                                self.chosenPalette = self.document.removeEmoji(emoji, fromPalette: chosenPalette)
                        }
                        
                    }.frame(height: height)
                }

                
            }
        }
        .onAppear { paletteName = self.document.paletteNames[self.chosenPalette] ?? "" }

    }
    
    var height: CGFloat {
        CGFloat((chosenPalette.count - 1) / 6) * 70 + 70
    }
    
    let fontSize: CGFloat = 40

}
