//
//  CodeView.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 26.10.2026..
//  Copyright © 2026 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct CodeView<AncillaryView>:View where AncillaryView: View {
    
    // MARK: Data in
    var code: Code
    
    // MARK: Data shared with me
    @Binding var selection: Int
    
    @ViewBuilder let ancillaryView: () -> AncillaryView
    
    // Mark: Data owned by me
    @Namespace private var selectionNamespace
    
    init(
        code: Code,
        selection: Binding<Int> = .constant(-1),
        @ViewBuilder ancillaryView: @escaping () -> AncillaryView = { EmptyView() }
    ) {
        self.code = code
        self._selection = selection
        self.ancillaryView = ancillaryView
    }
        
    var body: some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                PegView(peg: code.pegs[index])
                    .padding(Selection.border)
                    .background { // selection background
                        Group {
                            if selection == index, code.kind == .guess {
                                Selection.shape
                                    .foregroundStyle(Selection.color)
                                    .matchedGeometryEffect(id: "selection", in: selectionNamespace)
                            }
                        }
                        .animation(.selection, value: selection)
                    }
                    .overlay { // obscuring view
                        Selection.shape.foregroundStyle(code.isHidden ? Color.gray : .clear)
//                            .animation(nil, value: code.isHidden)
                            .transaction { transcation in
                                if code.isHidden {
                                    transcation.animation = nil
                                }
                            }
                    }
                    .onTapGesture {
                        if code.kind == .guess {
                            selection = index
                        }
                    }
            }
            Color.clear.aspectRatio(1, contentMode: .fit)
                .overlay {
                    ancillaryView()
//                    if let matches = code.matches {
//                        MatchMarkers(match: matches)
//                    } else {
//                        if code.kind == .guess {
//                            guessButton
//                        }
//                    }
                }
            }
    }
}

fileprivate struct Selection {
    static let border: CGFloat = 5
    static let cornerRadius: CGFloat = 10
    static let color: Color = Color.gray(0.85)
    static let shape = RoundedRectangle(cornerRadius: cornerRadius)
}



