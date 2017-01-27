//
//  EditSettingsInteractorSpec.swift
//  ClanManager
//
//  Created by Cheese Onhead on 1/18/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

@testable import ClanManager
import Quick
import Nimble

class EditSettingsInteractorSpec: QuickSpec
{
    override func spec()
    {
        describe("EditSettingsInteractor")
        {
            var interactor: EditSettingsInteractor!
            var workerSpy: SessionWorkerSpy!
            var outputSpy: EditSettingsInteractorOutputSpy!
            beforeEach
            {
                workerSpy = SessionWorkerSpy(store: SessionMemStore())
                outputSpy = EditSettingsInteractorOutputSpy()
                interactor = EditSettingsInteractor()
                interactor.sessionWorker = workerSpy
                interactor.output = outputSpy
            }

            context("when asked to fetch settings", {
                beforeEach
                {
                    workerSpy.fakeSettings = Settings(currentPlayerTag: "fakePlayerTag")
                    interactor.fetchSettings(request: EditSettings.FetchSettings.Request())
                }

                it("should send request to worker", closure: {
                    expect(workerSpy.fetchSettingsCalled).toEventually(beTrue())
                })

                it("should trigger present on output", closure: {
                    expect(outputSpy.presentSettingsCalled).toEventually(beTrue())
                })

                it("should send correct response to output", closure: {
                    expect(outputSpy.gotResponse.currentPlayerTag).toEventually(equal("fakePlayerTag"))
                })
            })

            context("when asked to fetch settings, nil returned")
            {
                beforeEach
                {
                    workerSpy.fakeSettings = nil
                    interactor.fetchSettings(request: EditSettings.FetchSettings.Request())
                }

                it("should send empty response to output")
                {
                    expect(outputSpy.gotResponse).toEventually(equal(EditSettings.FetchSettings.Response()))
                }
            }

            describe("when asked to store valid settings")
            {
                beforeEach
                {
                    let request = EditSettings.StoreSettings.Request(playerTag: "validPlayerTag")
                    let fakeStoreSettingsResult = StoreSettingsResult()

                    interactor.storeSettings(request: request)
                    workerSpy.fakeStoreSettingsResult = fakeStoreSettingsResult
                }

                it("should call store settings on worker")
                {
                    expect(workerSpy.storeSettingsCalled).toEventually(beTrue())
                }

                it("should send correct version of settings to worker")
                {
                    let expected = Settings(currentPlayerTag: "validPlayerTag")
                    expect(workerSpy.gotSettingsToStore).toEventually(equal(expected))
                }

                it("should trigger present on output")
                {
                    expect(outputSpy.presentStoreSettingsResultCalled).toEventually(beTrue())
                }
            }

            describe("when asked to store invalid settings")
            {
                context("when player tag is empty")
                {
                    beforeEach
                    {
                        let request = EditSettings.StoreSettings.Request(playerTag: "")
                        let fakeStoreSettingsResult = StoreSettingsResult(success: false, playerTagValidation: .errorEmpty)

                        interactor.storeSettings(request: request)
                        workerSpy.fakeStoreSettingsResult = fakeStoreSettingsResult
                    }

                    it("should not trigger method on worker")
                    {
                        expect(workerSpy.storeSettingsCalled).toNotEventually(beTrue())
                    }

                    it("should send appropriate response to output")
                    {
                        let expected = EditSettings.StoreSettings.Response(success: false, playerTagValidation: .empty)
                        expect(outputSpy.gotStoreSettingsResponse).toEventually(equal(expected))
                    }
                }

                context("when player tag contains spaces")
                {
                    beforeEach
                    {
                        let request = EditSettings.StoreSettings.Request(playerTag: "player tag")
                        let fakeStoreSettingsResult = StoreSettingsResult(success: false, playerTagValidation: .errorContainsSpaces)

                        interactor.storeSettings(request: request)
                        workerSpy.fakeStoreSettingsResult = fakeStoreSettingsResult
                    }

                    it("should not trigger method on worker")
                    {
                        expect(workerSpy.storeSettingsCalled).toNotEventually(beTrue())
                    }

                    it("should send appropriate response to output")
                    {
                        let expected = EditSettings.StoreSettings.Response(success: false, playerTagValidation: .containsSpaces)
                        expect(outputSpy.gotStoreSettingsResponse).toEventually(equal(expected))
                    }
                }
            }
        }
    }
}

fileprivate class SessionWorkerSpy: SessionWorker
{
    // Checks
    var fetchSettingsCalled = false
    var storeSettingsCalled = false
    var gotSettingsToStore: Settings!

    // Stub
    var fakeSettings: Settings!
    var fakeStoreSettingsResult: StoreSettingsResult!

    override func fetchSettings(completionHandler: @escaping (Settings?) -> Void)
    {
        fetchSettingsCalled = true
        completionHandler(fakeSettings)
    }

    override func storeSettings(settingsToStore: Settings, completionHandler: @escaping (StoreSettingsResult) -> Void)
    {
        storeSettingsCalled = true
        gotSettingsToStore = settingsToStore

        if fakeStoreSettingsResult != nil
        {
            completionHandler(fakeStoreSettingsResult)
        }
    }
}

fileprivate class EditSettingsInteractorOutputSpy: EditSettingsInteractorOutput
{
    // Checks
    var presentSettingsCalled = false
    var presentStoreSettingsResultCalled = false
    var gotResponse: EditSettings.FetchSettings.Response!
    var gotStoreSettingsResponse: EditSettings.StoreSettings.Response!

    func presentSettings(response: EditSettings.FetchSettings.Response)
    {
        presentSettingsCalled = true
        gotResponse = response
    }

    func presentStoreSettingsResult(response: EditSettings.StoreSettings.Response)
    {
        presentStoreSettingsResultCalled = true
        gotStoreSettingsResponse = response
    }
}
