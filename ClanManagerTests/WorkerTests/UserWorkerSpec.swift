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
                userStoreSpy.fakeUser = User(id: "uniqueId", firstName: "Barry", lastName: "Allen", townHallLevel: 8)
                
                userWorker = UserWorker(userStore: userStoreSpy)
            }

            context("when asked to fetch a user", {
                var resultUser: User!
                beforeEach
                {
                    userWorker.fetchUser(id: "thisIdDoesntExist", completionHandler: { user in
                        resultUser = user
                    })
                }

                it("should have made a request to the store", closure: {
                    expect(userStoreSpy.fetchUserCalled).toEventually(beTrue(), timeout: Double(userStoreSpy.asyncDelaySeconds) + 0.1)
                })
                
                it("should have made a request using the same id", closure: { 
                    expect(userStoreSpy.requestWithId).toEventually(equal("thisIdDoesntExist"), timeout: Double(userStoreSpy.asyncDelaySeconds) + 0.1)
                })
                
                it("should return with same user the store returned", closure: {
                    expect(resultUser).toEventually(equal(userStoreSpy.fakeUser), timeout: Double(userStoreSpy.asyncDelaySeconds) + 0.1)
                })
            })
        }
    }
}

fileprivate class UserMemStoreSpy: UserMemStore
{
    var asyncDelaySeconds = 1
    
    // MARK: - Stub
    var fakeUser: User!
    
    // MARK: - Spying
    var fetchUserCalled = false
    var requestWithId: String!

    override func fetchUser(id: String, completionHandler: @escaping (_: User) -> Void)
    {
        fetchUserCalled = true
        requestWithId = id
        let oneSecondAfter = DispatchTime.now() + DispatchTimeInterval.seconds(asyncDelaySeconds)
        DispatchQueue.main.asyncAfter(deadline: oneSecondAfter, execute: {
            completionHandler(self.fakeUser)
        })
    }
}
