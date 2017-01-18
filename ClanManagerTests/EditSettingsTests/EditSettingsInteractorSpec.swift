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
            beforeEach
            {
                workerSpy = SessionWorkerSpy()
                interactor = EditSettingsInteractor()
                interactor.sessionWorker = workerSpy
            }

            context("when asked to fetch settings", {
                beforeEach
                {
                    interactor.fetchSettings(request: EditSettings.FetchSettings.Request())
                }

                it("should send request to worker", closure: {
                    expect(workerSpy.fetchSettingsCalled).toEventually(beTrue())
                })
            })
        }
    }
}

fileprivate class SessionWorkerSpy: SessionWorker
{
    // Checks
    var fetchSettingsCalled = false

    override func fetchSettings(completionHandler _: @escaping (Settings?) -> Void)
    {
        fetchSettingsCalled = true
    }
}
