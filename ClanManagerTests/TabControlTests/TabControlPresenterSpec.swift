//
//  TabControlPresenterSpec.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-23.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

@testable import ClanManager
import Quick
import Nimble

class TabControlPresenterSpec: QuickSpec
{
    override func spec()
    {
        describe("TabControlPresenter")
        {
            var presenter: TabControlPresenter!

            beforeEach
            {
                presenter = TabControlPresenter()
            }
        }
    }
}

fileprivate class OutputSpy: TabControlPresenterOutput
{
    var displaySettingsCalled = false

    func displaySettings(viewModel _: TabControl.FetchSettings.ViewModel)
    {
        displaySettingsCalled = true
    }
}
