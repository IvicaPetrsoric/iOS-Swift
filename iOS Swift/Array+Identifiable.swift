//
//  Array+Identifiable.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 17/02/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    
    func firstIndex(matching: Element) -> Int?  {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
    
}
