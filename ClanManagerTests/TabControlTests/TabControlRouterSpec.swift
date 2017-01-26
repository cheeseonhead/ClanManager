//
//  TabControlRouterSpec.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-25.
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
            var viewControllerSPy: ViewControllerSpy!
            var viewUserVC: ViewUserViewControllerSpy!
            var dataSpy: DataSpy!

            beforeEach
            {
                viewControllerSPy = ViewControllerSpy(nibName: nil, bundle: nil)
                viewUserVC = ViewUserViewControllerSpy(nibName: nil, bundle: nil)
                dataSpy = DataSpy()
                viewUserVC.dataReceiver = dataSpy

                router = TabControlRouter(viewController: viewControllerSPy, dataSource: dataSpy, dataDestination: dataSpy)
                router.viewUserVC = viewUserVC
            }

            context("when asked to open settings view controller")
            {
                beforeEach
                {
                    router.openSettingsViewController()
                }

                it("should trigger perform segue")
                {
                    expect(viewControllerSPy.performSegueCalled).toEventually(beTrue())
                }
            }

            context("when asked to pass data to view user")
            {
                beforeEach
                {
                    router.passDataToViewUserViewController()
                }

                it("should trigger get on current player tag")
                {
                    expect(dataSpy.currentPlayerTagCalled).toEventually(beTrue())
                }

                it("should set view user's player tag")
                {
                    expect(dataSpy.playerTagSet).toEventually(beTrue())
                }

                it("should set view user's data correctly")
                {
                    expect(dataSpy.playerTag).toEventually(equal("someValidPlayerTag"))
                }
            }
        }
    }
}

fileprivate class ViewControllerSpy: UIViewController
{
    var performSegueCalled = false

    override func performSegue(withIdentifier _: String, sender _: Any?)
    {
        performSegueCalled = true
    }
}

fileprivate class ViewUserViewControllerSpy: ViewUserViewController {}

fileprivate class DataSpy: TabControlRouterDataProvider, TabControlRouterDataReceiver, ViewUserRouterDataReceiver
{
    // Checks
    var currentPlayerTagCalled = false
    var playerTagSet = false

    // Stubs
    var currentPlayerTag: String?
    {
        currentPlayerTagCalled = true
        return "someValidPlayerTag"
    }
    var playerTag: String! {
        didSet
        {
            playerTagSet = true
        }
    }
}
