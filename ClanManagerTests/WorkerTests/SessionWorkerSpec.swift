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
            var timeout: Double!

            beforeEach
            {
                fakeSettings = Settings(currentPlayerTag: "fakePlayerTag")
                worker = SessionWorker(store: SessionStoreSpy())
                storeSpy = worker.store as! SessionStoreSpy

                timeout = Double(storeSpy.asyncDelayMilliseconds) * TestGlobals.MILLI_TO_WHOLE_RATIO + 0.1
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
                    expect(resultSettings).toEventually(equal(fakeSettings), timeout: timeout)
                }
            }

            describe("when asked to store settings")
            {
                var fakeSettings: Settings!
                var storingResult: StoreSettingsResult!
                describe("invalid player tag")
                {
                    beforeEach
                    {
                        storingResult = StoreSettingsResult()
                    }

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
                            print(timeout)
                            expect(storingResult.success).toEventually(beFalse(), timeout: timeout)
                        }

                        it("should have result empty error")
                        {
                            expectedPlayerTagValidation = .errorEmpty
                            expect(storingResult.playerTagValidation).toEventually(equal(expectedPlayerTagValidation), timeout: timeout)
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
                            expect(storingResult.success).toEventually(beFalse(), timeout: timeout)
                        }

                        it("should have result contains space error")
                        {
                            expectedPlayerTagValidation = .errorContainsSpaces
                            expect(storingResult.playerTagValidation).toEventually(equal(expectedPlayerTagValidation), timeout: timeout)
                        }
                    }
                }

                describe("valid player tag")
                {
                    var expectedPlayerTagValidation: StoreSettingsResult.StringValidation!
                    beforeEach
                    {
                        fakeSettings = Settings(currentPlayerTag: "validPlayerTag")
                        storingResult = StoreSettingsResult(success: false, playerTagValidation: .errorEmpty)
                    }

                    it("should send request to store")
                    {
                        worker.storeSettings(settingsToStore: fakeSettings)
                        { result in
                            storingResult = result
                        }

                        expect(storeSpy.storeSettingsCalled).toEventually(beTrue())
                    }

                    it("should return success when store returns success")
                    {
                        storeSpy.storeSuccess = true
                        worker.storeSettings(settingsToStore: fakeSettings)
                        { result in
                            storingResult = result
                        }

                        expect(storingResult.success).toEventually(beTrue(), timeout: timeout)
                    }

                    it("should return failure when store returns failure")
                    {
                        storeSpy.storeSuccess = false
                        worker.storeSettings(settingsToStore: fakeSettings)
                        { result in
                            storingResult = result
                        }

                        expect(storingResult.success).toEventually(beFalse(), timeout: timeout)
                    }

                    it("should have result player tag valid")
                    {
                        worker.storeSettings(settingsToStore: fakeSettings)
                        { result in
                            storingResult = result
                        }

                        expectedPlayerTagValidation = .valid
                        expect(storingResult.playerTagValidation).toEventually(equal(expectedPlayerTagValidation), timeout: timeout)
                    }
                }
            }
        }
    }
}

class SessionStoreSpy: SessionStoreProtocol
{
    var asyncDelayMilliseconds = TestGlobals.ASYNC_DELAY_MILLISECONDS

    // Checks
    var fetchSettingsCalled = false
    var storeSettingsCalled = false

    // Stubs
    var fakeSettings: Settings!
    var storeSuccess: Bool = true

    func fetchSettings(completionHandler: @escaping (Settings?) -> Void)
    {
        fetchSettingsCalled = true
        let smallDelayAfter = DispatchTime.now() + DispatchTimeInterval.milliseconds(asyncDelayMilliseconds)
        DispatchQueue.main.asyncAfter(deadline: smallDelayAfter, execute: {
            completionHandler(self.fakeSettings)
        })
    }

    func storeSettings(settingsToStore _: Settings, completionHandler: @escaping (SessionStore.UpdateResult) -> Void)
    {
        storeSettingsCalled = true
        let smallDelayAfter = DispatchTime.now() + DispatchTimeInterval.milliseconds(asyncDelayMilliseconds)
        DispatchQueue.main.asyncAfter(deadline: smallDelayAfter, execute: {
            completionHandler(SessionStore.UpdateResult(success: self.storeSuccess))
        })
    }
}
