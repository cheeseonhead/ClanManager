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
            var sessionWorkerSpy: SessionWorkerSpy!

            beforeEach
            {
                interactor = TabControlInteractor()
                outputSpy = OutputSpy()
                sessionWorkerSpy = SessionWorkerSpy(store: SessionMemStore())

                interactor.output = outputSpy
                interactor.sessionWorker = sessionWorkerSpy
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

fileprivate class SessionWorkerSpy: SessionWorker
{
    // Checks
    var fetchSettingsCalled = false

    // Stub
    var fakeSettings: Settings!

    override func fetchSettings(completionHandler: @escaping (Settings?) -> Void)
    {
        fetchSettingsCalled = true
        completionHandler(fakeSettings)
    }
}
