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

            beforeEach
            {
                worker = SessionWorker(store: SessionStoreSpy())
                storeSpy = worker.store as! SessionStoreSpy
            }

            context("when asked to fetch settings")
            {
                beforeEach
                {
                    worker.fetchSettings(completionHandler: { _ in })
                }

                it("should send a request to the store")
                {
                    expect(storeSpy.fetchSettingsCalled).toEventually(beTrue())
                }
            }
        }
    }
}

class SessionStoreSpy: SessionMemStore
{
    // Checks
    var fetchSettingsCalled = false

    override func fetchSettings(completionHandler _: @escaping (Settings?) -> Void)
    {
        fetchSettingsCalled = true
    }
}
