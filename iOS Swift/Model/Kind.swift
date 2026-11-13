//
//  Kind.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 13.11.2026..
//  Copyright © 2026 ivica petrsoric. All rights reserved.
//



enum Kind: Equatable, CustomStringConvertible {
    case master(isHidden: Bool)
    case guess
    case attempt([Match])
    case unknown

    // Kind → String
    var description: String {
        switch self {
        case .master(let isHidden):
            return "master:\(isHidden)"

        case .guess:
            return "guess"

        case .attempt(let matches):
            let matchStr = matches.map { $0.rawValue }.joined(separator: ",")
            return "attempt:\(matchStr)"

        case .unknown:
            return "unknown"
        }
    }

    // String → Kind (non-failable)
    init(_ stringValue: String) {
        let parts = stringValue.split(
            separator: ":",
            maxSplits: 1
        )

        switch parts.first {
        case "master":
            let hidden = parts.count > 1
                ? parts[1] == "true"
                : false
            self = .master(isHidden: hidden)

        case "guess":
            self = .guess

        case "attempt":
            let matches = parts.count > 1
                ? parts[1].split(separator: ",").compactMap {
                    Match(rawValue: String($0))
                }
                : []
            self = .attempt(matches)

        case "unknown":
            self = .unknown

        default:
            self = .unknown
        }
    }
}
