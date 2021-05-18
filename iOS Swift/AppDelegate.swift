//
//  AppDelegate.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let persistenceContainer = PersistenceController.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let starterView = StartView()
            .environment(\.managedObjectContext,
                                       persistenceContainer.container.viewContext)
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: UIHostingController(rootView: starterView))
        window?.makeKeyAndVisible()

        return true
    }


}

