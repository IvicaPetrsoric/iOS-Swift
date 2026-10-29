//
//  PegView.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 24.10.2026..
//  Copyright © 2026 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct PegView: View {
    
    // MARK: - Data in
    
    let peg: Peg
    
    // MARK: - Body
    let pegShape = RoundedRectangle(cornerRadius: 10)

    var body: some View {
        pegShape
            .contentShape(pegShape)
            .aspectRatio(1, contentMode: .fit)
            .foregroundStyle(peg)
    }
}

#Preview {
    PegView(peg: Peg(.green))
}
