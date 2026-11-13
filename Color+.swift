//
//  Color+.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 13.11.2026..
//  Copyright © 2026 ivica petrsoric. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {

    // Color → String (Hex)
    var hex: String {
        let uiColor = UIColor(self)

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        uiColor.getRed(
            &red,
            green: &green,
            blue: &blue,
            alpha: &alpha
        )

        return String(
            format: "#%02X%02X%02X%02X",
            Int(red * 255),
            Int(green * 255),
            Int(blue * 255),
            Int(alpha * 255)
        )
    }

    // String → Color (Non-failable)
    init(hex: String) {
        let hex = hex
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")

        guard let value = UInt64(hex, radix: 16) else {
            self = .clear
            return
        }

        switch hex.count {
        case 6:
            self.init(
                .sRGB,
                red: Double((value >> 16) & 0xFF) / 255,
                green: Double((value >> 8) & 0xFF) / 255,
                blue: Double(value & 0xFF) / 255,
                opacity: 1
            )

        case 8:
            self.init(
                .sRGB,
                red: Double((value >> 24) & 0xFF) / 255,
                green: Double((value >> 16) & 0xFF) / 255,
                blue: Double((value >> 8) & 0xFF) / 255,
                opacity: Double(value & 0xFF) / 255
            )

        default:
            self = .clear
        }
    }
}
