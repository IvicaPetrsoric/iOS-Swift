//
//  RCValues.swift
//  ReColor
//
//  Created by ivica petrsoric on 30/05/2018.
//  Copyright © 2018 Sumoing. All rights reserved.
//

import Foundation
import Firebase

class RCValues {
    
    static let sharedInstance = RCValues()
    
    var loadingDoneCallback: (() -> ())?
    var fetchComplete: Bool = false
    
    enum ValueKey: String {
        case minimumiOSBuild
    }
    
    private init() {
        fetchCloudValues()
    }
    
    func loadDefaultValues() {
        let appDefaults: [String: NSObject] = [
            ValueKey.minimumiOSBuild.rawValue: -1 as NSObject
        ]
        
        RemoteConfig.remoteConfig()
    }
    
    func fetchCloudValues() {
        // 1
        // for real devices deployment use aprox 12h so it doesn't fetch to early, cashing is on
        let fetchDuration: TimeInterval = 0
        activateDebugMode()
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: fetchDuration) { [weak self] (status, error) in
            
            guard error == nil else {
                print ("Uh-oh. Got an error fetching remote values \(error)")
                return
            }
            
            RemoteConfig.remoteConfig().activateFetched()
            print ("Retrieved values from the cloud!")
            
//            print ("Minimum vesion of support  \(RemoteConfig.remoteConfig().configValue(forKey: ValueKey.minimumiOSBuild.rawValue).stringValue)")
            
            self?.fetchComplete = true
            self?.loadingDoneCallback?()
        }
    }
    
    func activateDebugMode() {
        let debugSettings = RemoteConfigSettings(developerModeEnabled: true)
        RemoteConfig.remoteConfig().configSettings = debugSettings!
    }
    
    
//    func getColor(forKey key: ValueKey) -> UIColor {
//        let colorAsHexString = RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? "#FFFFFFFF"
//        let convertedColor = UIColor(rgba: colorAsHexString)
//        return convertedColor
//    }
    
    func getBool(forKey key: ValueKey) -> Bool {
        return RemoteConfig.remoteConfig()[key.rawValue].boolValue
    }
    
    func getString(forKey key: ValueKey) -> String {
        return RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
    }
    
    func getDouble(forKey key: ValueKey) -> Double {
        if let numberValue = RemoteConfig.remoteConfig()[key.rawValue].numberValue {
            return numberValue.doubleValue
        } else {
            return 0.0
        }
    }
}
