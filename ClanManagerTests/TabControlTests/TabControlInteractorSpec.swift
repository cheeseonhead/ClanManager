//
// Created by Cheese Onhead on 1/22/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

@testable import ClanManager
import Quick
import Nimble

class TabControlInteractorSpec: QuickSpec
{
    override func spec()
    {
        describe("TabControlInteractor")
        {
            var interactor: TabControlInteractor!
            var outputSpy: OutputSpy!

            beforeEach
            {
                interactor = TabControlInteractor()
                outputSpy = OutputSpy()

                interactor.output = outputSpy
            }
        }
    }
}

fileprivate class OutputSpy: TabControlInteractorOutput
{
    // Check
    var presentSettingCalled = false

    func presentSettings(response _: TabControl.FetchSettings.Response)
    {
        presentSettingCalled = true
    }
}
