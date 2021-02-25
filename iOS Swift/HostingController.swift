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
        // Get the managed object context from the shared persistent container.
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
        // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
//        let airport = Airport.withICAO("KSFO", context: context)
//        airport.fetchIncomingFlights()
        
        
        let contentView = FlightsEnrouteView(flightSearch: FlightSearch(destination: "KSFO"))
            .environment(\.managedObjectContext, context)


        super.init(rootView: contentView as! FlightsEnrouteView)

    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
