//
//  AppDelegate.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let persistenceContainer = PersistenceController.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = HostingController()

        return true
    }


}

//import SwiftUI
//
//@main
//struct iOS_Swift: App {
//    
//    let persistenceContainer = PersistenceController.shared
//
//    
//    var body: some Scene {
//        WindowGroup {
//            TestCoreData().environment(\.managedObjectContext,
//                                       persistenceContainer.container.viewContext)
//        }
//    }
//}

