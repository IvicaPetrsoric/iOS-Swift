//
//  ElapsedTime.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 30.10.2026..
//  Copyright © 2026 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct ElapsedTime: View {
    
    let startTime: Date?
    let endTime: Date?
    let elapsedTime: TimeInterval
    
    private var format: SystemFormatStyle.DateOffset {
        .offset(to: startTime! - elapsedTime, allowedFields: [.minute, .second])
    }
    
    var body: some View {
        if startTime != nil {
            if let endTime {
                Text(endTime, format: format)
            } else {
                Text(TimeDataSource<Date>.currentDate, format: format)
            }
        }
        else {
            Image(systemName: "pause")
        }
    }
}

