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
        }
    }
}

fileprivate class ViewControllerSpy: UIViewController
{
    var prepareForSegueCalled = false

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        prepareForSegueCalled = true
    }
}

fileprivate class DataSpy: TabControlRouterDataProvider, TabControlRouterDataReceiver
{
    var currentPlayerTag: String?
}
