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

            context("when asked to store settings")
            {
                it("should send request to store when player tag valid")
                {
                    var fakeSettings = Settings(currentPlayerTag: "")
                    worker.storeSettings(settingsToStore: fakeSettings) { _ in }
                    expect(storeSpy.storeSettingsCalled).toEventually(beTrue())
                }

                it("should not send request to store when player tag is empty")
                {
                    var fakeSettings = Settings(currentPlayerTag: "")
                    worker.storeSettings(settingsToStore: fakeSettings) { _ in }
                    expect(storeSpy.storeSettingsCalled).toNotEventually(beTrue())
                }

                it("should not send request to store when player tag contains space")
                {
                    var fakeSettings = Settings(currentPlayerTag: "player tag")
                    worker.storeSettings(settingsToStore: fakeSettings) { _ in }
                    expect(storeSpy.storeSettingsCalled).toNotEventually(beTrue())
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
    var storeSettingsCalled = false

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

    override func storeSettings(settingsToStore _: Settings, completionHandler: @escaping (Bool, Settings?) -> Void)
    {
        storeSettingsCalled = true
        let smallDelayAfter = DispatchTime.now() + DispatchTimeInterval.milliseconds(asyncDelayMilliseconds)
        DispatchQueue.main.asyncAfter(deadline: smallDelayAfter, execute: {
            completionHandler(true, self.fakeSettings)
        })
    }
}
