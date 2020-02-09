//
//  Double+Extensions.swift
//  GoodWeather
//
//  Created by ivica petrsoric on 29/10/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import Foundation

extension Double {
    
    var formatAsDegree: String {
        return String(format: "%.0f°", self)
    }
    
}
