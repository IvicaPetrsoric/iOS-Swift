//
//  ExpandableNames.swift
//  PhoneTableList
//
//  Created by Ivica Petrsoric on 20/11/2017.
//  Copyright © 2017 Ivica Petrsoric. All rights reserved.
//

import Foundation
import Contacts

struct ExpandableNames{
    
    var isExpanded: Bool
    var names: [FavoritableContact]
}

struct FavoritableContact {
    let contact: CNContact
    var hasFavorite: Bool
}
