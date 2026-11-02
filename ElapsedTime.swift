//
//  ElapsedTime.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 30.10.2026..
//  Copyright © 2026 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct ElapsedTime: View {
    
    let startTime: Date
    let endTime: Date?
    
    var body: some View {
        if let endTime {
            if #available(iOS 18.0, *) {
                Text(endTime, format: .offset(to: startTime, allowedFields: [.minute, .second]))
            } else {
                // Fallback on earlier versions
            }
        } else {
            if #available(iOS 18.0, *) {
                Text(TimeDataSource<Date>.currentDate, format: .offset(to: startTime, allowedFields: [.minute, .second]))
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

