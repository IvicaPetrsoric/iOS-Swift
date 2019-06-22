//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class ViewController: UIViewController, CBPeripheralManagerDelegate  {
    
    var localBeacon: CLBeaconRegion!
    var beaconPeripheralData: NSDictionary!
    var peripheralManager: CBPeripheralManager!
    
    let beaconUUID = "95E00D69-6DDF-4DFF-A9FB-B867FDA7E837"
    let beaconId = "region"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLocalBeacon()
        navigationItem.title = "Start Beaconing! :D "
        
        view.backgroundColor = .lightGray
    }
    
    func initLocalBeacon() {
        if localBeacon != nil {
            stopLocalBeacon()
        }
        
        let localBeaconUUID = beaconUUID
        let localBaconMinor: CLBeaconMinorValue = 200
        let localBeaconMajor: CLBeaconMajorValue = 250
        
        guard let uuid = UUID(uuidString: localBeaconUUID) else { return }
        localBeacon = CLBeaconRegion(proximityUUID: uuid, major: localBeaconMajor, minor: localBaconMinor, identifier: beaconId)
        
        beaconPeripheralData = localBeacon.peripheralData(withMeasuredPower: nil)
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
    }
    
    func stopLocalBeacon() {
        print("Stop Local Beacon")
        peripheralManager.stopAdvertising()
        peripheralManager = nil
        beaconPeripheralData = nil
        localBeacon = nil
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            print("Start advertising!")
            peripheralManager.startAdvertising(beaconPeripheralData as! [String: AnyObject])
        } else if peripheral.state == .poweredOff {
            print("Stop advertising!")
            peripheralManager.stopAdvertising()
        }
    }
    
}

