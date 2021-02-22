//
//  Spinning.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 22/02/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct Spinning: ViewModifier {
    
    @State var isVisible = false
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: isVisible ? 360 : 30))
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
            .onAppear { self.isVisible = true }
    }
    
}

extension View {
    
    func spinning() -> some View {
        self.modifier(Spinning())
    }
    
}
