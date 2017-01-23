//
//  SessionWorkerSpec.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-18.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

@testable import ClanManager
import Quick
import Nimble

class SessionWorkerSpec: QuickSpec
{
    override func spec()
    {
        describe("SessionWorker")
        {
            var worker: SessionWorker!
            var storeSpy: SessionStoreSpy!
            var fakeSettings: Settings!

            beforeEach
            {
                fakeSettings = Settings(currentPlayerTag: "fakePlayerTag")
                worker = SessionWorker(store: SessionStoreSpy())
                storeSpy = worker.store as! SessionStoreSpy
            }

            context("when asked to fetch settings")
            {
                var resultSettings: Settings!
                beforeEach
                {
                    storeSpy.fakeSettings = fakeSettings
                    worker.fetchSettings(completionHandler: { settings in resultSettings = settings })
                }

                it("should send a request to the store")
                {
                    expect(storeSpy.fetchSettingsCalled).toEventually(beTrue())
                }

                it("should return same result from the store")
                {
                    expect(resultSettings).toEventually(equal(fakeSettings), timeout: Double(storeSpy.asyncDelayMilliseconds) + 0.1)
                }
            }
        }
    }
}

class SessionStoreSpy: SessionMemStore
{
    var asyncDelayMilliseconds = TestGlobals.ASYNC_DELAY_MILLISECONDS

    // Checks
    var fetchSettingsCalled = false

    // Stubs
    var fakeSettings: Settings!

    override func fetchSettings(completionHandler: @escaping (Settings?) -> Void)
    {
        fetchSettingsCalled = true
        let smallDelayAfter = DispatchTime.now() + DispatchTimeInterval.milliseconds(asyncDelayMilliseconds)
        DispatchQueue.main.asyncAfter(deadline: smallDelayAfter, execute: {
            completionHandler(self.fakeSettings)
        })
    }
}
