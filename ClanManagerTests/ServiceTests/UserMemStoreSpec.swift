//
// Created by Jeffrey Wu on 2017-01-16.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

@testable import ClanManager
import Quick
import Nimble

class UserMemStoreSpec: QuickSpec {
    override func spec()
    {
        describe("UserMemStore") { 
            var userMemStore: UserMemStore!
            var testUsers: [User]!
            beforeEach {
                userMemStore = UserMemStore()
                testUsers = [User(), User()]
                userMemStore.users = testUsers
            }
            
            context("when asked to get a list of users", {
                var resultUsers: User!
                beforeEach {
                    userMemStore.fetchUsers(completionHandler: { (users) in
                        resultUsers = users
                    })
                }
                
                it("should return a list of users", closure: {
                    expect(resultUsers).toEventually(be)
                })
            })
        }
    }
}
