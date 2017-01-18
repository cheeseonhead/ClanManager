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
                
                it("should send correct response to output", closure: {
                    expect(outputSpy.gotResponse.currentPlayerTag).toEventually(equal("fakePlayerTag"))
                })
            })
        }
    }
}

fileprivate class SessionWorkerSpy: SessionWorker
{
    // Checks
    var fetchSettingsCalled = false
    
    // Stub
    var fakeSettings: Settings!

    override func fetchSettings(completionHandler _: @escaping (Settings?) -> Void)
    {
        fetchSettingsCalled = true
    }
}

fileprivate class EditSettingsInteractorOutputSpy: EditSettingsInteractorOutput
{
    // Checks
    var gotResponse: EditSettings.FetchSettings.Response!
    
    func presentSettings(response: EditSettings.FetchSettings.Response)
    {
        gotResponse = response
    }
}
