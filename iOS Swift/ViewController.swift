//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let beaconUUID = "95E00D69-6DDF-4DFF-A9FB-B867FDA7E837"
    let beaconId = "region"
    
    let colors = [
        100: UIColor.red,
        200: UIColor.orange,
        300: UIColor.green
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse{
            locationManager.requestWhenInUseAuthorization()
        }
        
        guard let proxUUID = UUID(uuidString: beaconUUID) else { return }
        
        let region = CLBeaconRegion(proximityUUID: proxUUID, identifier: beaconId)
        
        locationManager.startRangingBeacons(in: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print(beacons)
        let knownBeacons = beacons.filter { $0.proximity != CLProximity.unknown }
        if knownBeacons.count > 0 {
            let closestBeacon = knownBeacons[0] as CLBeacon
            //            self.view.backgroundColor = self.colors[closestBeacon.minor.intValue]
            
            let distance = (closestBeacon.proximity.rawValue)
            //            print(distance)
            
            switch  distance{
                
            case 1:
                navigationItem.title = "Near"
                self.view.backgroundColor = .green
                
            case 2:
                navigationItem.title = "Mid range"
                self.view.backgroundColor = .orange
                
            case 3:
                navigationItem.title = "Far"
                self.view.backgroundColor = .red
                
            default:
                self.view.backgroundColor = .gray
            }
            
        } else {
            self.view.backgroundColor = .black
        }
    }
    
    
}

