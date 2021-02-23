//
//  HostingController.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 15/02/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import Foundation

import SwiftUI

class HostingController: UIHostingController<FlightsEnrouteView> {
    
    init() {
        let contentView = FlightsEnrouteView(flightSearch: FlightSearch(destination: "KSFO"))

        super.init(rootView: contentView)

    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
