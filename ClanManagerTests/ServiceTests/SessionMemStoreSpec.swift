//
//  SessionMemStoreSpec.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-19.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

@testable import ClanManager
import Quick
import Nimble

class SessionMemStoreSpec: QuickSpec
{
    override func spec()
    {
        describe("SessionMemStore")
        {
            var store: SessionMemStore!

            beforeEach
            {
                store = SessionMemStore()
            }

            context("when asked to save settings")
            {
                var fakeSettings: Settings!
                var storingResult: SessionStore.UpdateResult!
                beforeEach
                {
                    fakeSettings = Settings(currentPlayerTag: "fakePlayerTag")
                    store.storeSettings(settingsToStore: fakeSettings)
                    { result in
                        storingResult = result
                    }
                }

                it("should return successful")
                {
                    expect(storingResult.success).toEventually(beTrue())
                }

                context("when asked to fetch settings")
                {
                    var resultSettings: Settings!
                    beforeEach
                    {
                        store.fetchSettings { settings in resultSettings = settings }
                    }

                    it("should retrieve the same settings on fetch")
                    {
                        expect(resultSettings).toEventually(equal(fakeSettings))
                    }
                }
            }
        }
    }
}
