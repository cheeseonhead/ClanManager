//
//  TabControlViewControllerSpec.swift
//  ClanManager
//
//  Created by Cheese Onhead on 1/22/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Quick
import Nimble
@testable import ClanManager

class TabControlViewControllerSpec: QuickSpec
{
    var viewController: TabControlViewController!
    var window: UIWindow!

    override func spec()
    {
        describe("TabControlViewController")
        {

            beforeEach
            {
                self.setupViewController()
            }
        }
    }

    // MARK: Helpers
    func setupViewController()
    {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        viewController = storyboard.instantiateViewController(withIdentifier: "TabControlViewController") as! TabControlViewController
    }

    func loadView()
    {
        window = UIWindow()
        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }
}
