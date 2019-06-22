//
//  UserDefaultsHelpers.swift
//  audible
//
//  Created by Ivica Petrsoric on 18/10/2017.
//  Copyright © 2017 Ivica Petrsoric. All rights reserved.
//

import UIKit

extension UserDefaults{
    
    enum UserDefaultsKeys: String{
        case isLoggedIn
    }
    
    func setIsLoggedIn(value: Bool){
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func isLoggedIn() -> Bool{
       return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
}
