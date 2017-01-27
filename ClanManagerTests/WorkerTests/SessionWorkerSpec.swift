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

            describe("when asked to store settings")
            {
                var fakeSettings: Settings!
                var storingResult: StoreSettingsResult!
                describe("invalid player tag")
                {
                    var expectedPlayerTagValidation: StoreSettingsResult.StringValidation!
                    context("when player tag is empty")
                    {
                        beforeEach
                        {
                            fakeSettings = Settings(currentPlayerTag: "")
                            worker.storeSettings(settingsToStore: fakeSettings)
                            { result in
                                storingResult = result
                            }
                        }

                        it("should not send request to store")
                        {
                            expect(storeSpy.storeSettingsCalled).toNotEventually(beTrue())
                        }

                        it("should have result failed")
                        {
                            expect(storingResult.success).toEventually(beFalse())
                        }

                        it("should have result empty error")
                        {
                            expectedPlayerTagValidation = .errorEmpty
                            expect(storingResult.playerTagValidation).toEventually(equal(expectedPlayerTagValidation))
                        }
                    }

                    context("when player tag contains spaces")
                    {
                        beforeEach
                        {
                            fakeSettings = Settings(currentPlayerTag: "helllo this has space")
                            worker.storeSettings(settingsToStore: fakeSettings)
                            { result in
                                storingResult = result
                            }
                        }

                        it("should not send request to store")
                        {
                            expect(storeSpy.storeSettingsCalled).toNotEventually(beTrue())
                        }

                        it("should return failed")
                        {
                            expect(storingResult.success).toEventually(beFalse())
                        }

                        it("should have result contains space error")
                        {
                            expectedPlayerTagValidation = .errorContainsSpaces
                            expect(storingResult.playerTagValidation).toEventually(equal(expectedPlayerTagValidation))
                        }
                    }
                }

                describe("valid player tag")
                {
                    var expectedPlayerTagValidation: StoreSettingsResult.StringValidation!
                    beforeEach
                    {
                        fakeSettings = Settings(currentPlayerTag: "helllo this has space")
                        worker.storeSettings(settingsToStore: fakeSettings)
                        { result in
                            storingResult = result
                        }
                    }

                    it("should send request to store")
                    {
                        expect(storeSpy.storeSettingsCalled).toEventually(beTrue())
                    }

                    it("should return success")
                    {
                        expect(storingResult.success).toEventually(beTrue())
                    }

                    it("should have result player tag valid")
                    {
                        expectedPlayerTagValidation = .valid
                        expect(storingResult.playerTagValidation).toEventually(equal(expectedPlayerTagValidation))
                    }
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
    var storeSuccess: Bool!

    override func fetchSettings(completionHandler: @escaping (Settings?) -> Void)
    {
        fetchSettingsCalled = true
        let smallDelayAfter = DispatchTime.now() + DispatchTimeInterval.milliseconds(asyncDelayMilliseconds)
        DispatchQueue.main.asyncAfter(deadline: smallDelayAfter, execute: {
            completionHandler(self.fakeSettings)
        })
    }

    override func storeSettings(settingsToStore _: Settings, completionHandler: @escaping (SessionStore.UpdateResult) -> Void)
    {
        storeSettingsCalled = true
        let smallDelayAfter = DispatchTime.now() + DispatchTimeInterval.milliseconds(asyncDelayMilliseconds)
        DispatchQueue.main.asyncAfter(deadline: smallDelayAfter, execute: {
            completionHandler(SessionStore.UpdateResult(success: self.storeSuccess))
        })
    }
}
