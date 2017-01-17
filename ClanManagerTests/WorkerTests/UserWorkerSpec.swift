//
//  UserWorkerSpec.swift
//  ClanManager
//
//  Created by Cheese Onhead on 1/17/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

@testable import ClanManager
import Quick
import Nimble

class UserWorkerSpec: QuickSpec
{

    override func spec()
    {
        describe("UserWorker")
        {
            var userWorker: UserWorker!
            var userStoreSpy: UserMemStoreSpy!
            beforeEach
            {
                userStoreSpy = UserMemStoreSpy()
                userWorker = UserWorker(userStore: userStoreSpy)
            }

            context("when asked to fetch a user", {
                beforeEach
                {
                    userWorker.fetchUser(id: "thisIdDoesntExist", completionHandler: { _ in })
                }

                it("should have made a request to the store", closure: {
                    expect(userStoreSpy.fetchUserCalled).toEventually(beTrue(), timeout: Double(userStoreSpy.asyncDelaySeconds) + 0.1)
                })
            })
        }
    }
}

fileprivate class UserMemStoreSpy: UserMemStore
{
    var fetchUserCalled = false
    var asyncDelaySeconds = 1

    override func fetchUser(id _: String, completionHandler: @escaping (_: User) -> Void)
    {
        fetchUserCalled = true
        let oneSecondAfter = DispatchTime.now() + DispatchTimeInterval.seconds(asyncDelaySeconds)
        DispatchQueue.main.asyncAfter(deadline: oneSecondAfter, execute: {
            completionHandler(User())
        })
    }
}
