//
//  AppDelegate.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-13.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import UIKit

func isRunningUnitTests() -> Bool
{
    return NSClassFromString("XCTestCase") != nil
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {

        if isRunningUnitTests()
        {
            print("TESTING")

            // Create an empty window. Useful for unit tests that might need to alter the view heirarchy or
            // add views during their tests.
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = UIViewController()
            window.makeKeyAndVisible()
            self.window = window

            return true
        }

        BuddyBuildSDK.setup()

        return true
    }
}
