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
                var returnedSettings: Settings!
                beforeEach
                {
                    fakeSettings = Settings(currentPlayerTag: "fakePlayerTag")
                    store.saveSettings(newSettings: fakeSettings) { settings in returnedSettings = settings }
                }

                it("should return the same settings")
                {
                    expect(returnedSettings).toEventually(equal(fakeSettings))
                }
            }
        }
    }
}
