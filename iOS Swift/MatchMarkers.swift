//
//  MatchMarkers.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 22.10.2026..
//  Copyright © 2026 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct MatchMarkers: View {
    
    var match: [Match]
    
    var body: some View {
        HStack {
            VStack {
                matchMarker(peg: 0)
                matchMarker(peg: 1)
            }
            VStack {
                matchMarker(peg: 2)
                matchMarker(peg: 3)
            }
        }
    }
    
    func matchMarker(peg: Int) -> some View {
        let exactCount: Int = match.count(where: { match in match == .exact})
        let foundCount: Int = match.count(where: { match in match != .nomatch})

        return Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2).aspectRatio(1, contentMode: .fit)
    }
}

//
//#Preview {
//    MatchMarkers()
//}
