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

        if fakeStoreSettingsResult != nil {
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
