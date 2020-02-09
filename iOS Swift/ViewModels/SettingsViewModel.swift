//
//  SettingsViewModel.swift
//  GoodWeather
//
//  Created by ivica petrsoric on 29/10/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import Foundation

enum Unit: String, CaseIterable {
    
    case celcius = "metric"
    case fahrenheit = "imperial"
    
    var displayName: String {
        get {
            switch self {
                case .celcius:
                    return "Celsius"
                case .fahrenheit:
                    return "Fahrenheit"
            }
        }
    }
    
}

struct SettingsViewModel {
    
    let units = Unit.allCases
    private var _selecteUnit: Unit = .fahrenheit
    
    var selectedUnit: Unit {
        get {
            let userDefaults = UserDefaults.standard
            
            if let value = userDefaults.value(forKey: "unit") as? String {
                return Unit(rawValue: value)!
            }
            
            return _selecteUnit
        } set {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newValue.rawValue, forKey: "unit")
        }
    }
    
}
