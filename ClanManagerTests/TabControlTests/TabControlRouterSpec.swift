//
//  TabControlRouterSpec.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-24.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

@testable import ClanManager
import Quick
import Nimble

class TabControlRouterSpec: QuickSpec
{
    override func spec()
    {
        describe("TabControlRouter")
        {
            var router: TabControlRouter!
            var vcSpy: ViewControllerSpy!
            var dataSpy: DataSpy!

            beforeEach
            {
                vcSpy = ViewControllerSpy(nibName: nil, bundle: nil)
                dataSpy = DataSpy()
                router = TabControlRouter(viewController: vcSpy, dataSource: dataSpy, dataDestination: dataSpy)
            }

            context("when asked to open settings view controller")
            {
                beforeEach
                {
                    router.openSettingsViewController()
                }

                it("should trigger prepare for segue")
                {
                    expect(vcSpy.performSegueCalled).toEventually(beTrue())
                }
            }
        }
    }
}

fileprivate class ViewControllerSpy: UITabBarController
{
    var performSegueCalled = false

    override func performSegue(withIdentifier _: String, sender _: Any?)
    {
        performSegueCalled = true
    }
}

fileprivate class DataSpy: TabControlRouterDataProvider, TabControlRouterDataReceiver
{
    // Checks
    var currentPlayerTagCalled = false

    var currentPlayerTag: String?
    {
        currentPlayerTagCalled = true
        return "RandomPlayerTag"
    }
}
