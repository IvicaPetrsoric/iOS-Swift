//
//  HostingController.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 15/02/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import Foundation

import SwiftUI

class HostingController: UIHostingController<WorkoutView> {
    
    init() {
        let data = Workout(title: "test", date: "test", duration: "test", sfSymbol: "test")
        super.init(rootView: WorkoutView(workout: data))

    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
