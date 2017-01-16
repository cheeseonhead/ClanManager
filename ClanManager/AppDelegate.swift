//
//  AppDelegate.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-13.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        BuddyBuildSDK.setup()
        
        // Override point for customization after application launch.
        return true
    }
}

