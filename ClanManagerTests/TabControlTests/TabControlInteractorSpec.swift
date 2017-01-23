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

            context("when asked to fetch valid settings")
            {
                beforeEach
                {
                    sessionWorkerSpy.fakeSettings = Settings(currentPlayerTag: "validPlayerTag")
                    interactor.fetchSettings(request: TabControl.FetchSettings.Request())
                }

                it("should make a request to the worker to get the settings")
                {
                    expect(sessionWorkerSpy.fetchSettingsCalled).toEventually(beTrue())
                }

                it("should send a response to the output")
                {
                    expect(outputSpy.presentSettingCalled).toEventually(beTrue())
                }

                it("should send a valid response to the output")
                {
                    var expected = TabControl.FetchSettings.Response(currentPlayerTag: "validPlayerTag")
                    expect(outputSpy.gotResponse).toEventually(equal(expected))
                }
            }

            context("when asked to fetch settings with nil values")
            {
                beforeEach
                {
                    sessionWorkerSpy.fakeSettings = nil
                    interactor.fetchSettings(request: TabControl.FetchSettings.Request())
                }

                it("should send an empty response to the output")
                {
                    expect(outputSpy.gotResponse).toEventually(equal(TabControl.FetchSettings.Response()))
                }
            }
        }
    }
}

fileprivate class OutputSpy: TabControlInteractorOutput
{
    // Check
    var presentSettingCalled = false
    var gotResponse: TabControl.FetchSettings.Response!

    func presentSettings(response: TabControl.FetchSettings.Response)
    {
        presentSettingCalled = true
        gotResponse = response
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
