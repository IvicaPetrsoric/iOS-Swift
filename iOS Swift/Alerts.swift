//
//  Alerts.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 13/05/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct AlertItem: Identifiable {
    
    let id = UUID()
    
    var title: Text
    var message: Text
    var buttonTitle: Text
    
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You Win"),
                                    message: Text("You are so smart. You beat your won AI"),
                                    buttonTitle: Text("Hell yeah"))
    
    static let computerwin = AlertItem(title: Text("You Lost"),
                                       message: Text("You progrmed a super AI."),
                                       buttonTitle: Text("Rematchs"))
    
    static let draw = AlertItem(title: Text("Draw"),
                                message: Text("What a battle of wits we have here..."),
                                buttonTitle: Text("Try Again"))
}
