//
// Created by Jeffrey Wu on 2017-01-16.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

@testable import ClanManager
import Quick
import Nimble

class UserMemStoreSpec: QuickSpec
{
    override func spec()
    {
        describe("UserMemStore")
        {
            var userMemStore: UserMemStore!
            var testUsers: [User]!
            beforeEach
            {
                testUsers = [
                    User(id: "firstUser", firstName: "Barry", lastName: "Allen", townHallLevel: 8),
                    User(id: "secondUser", firstName: "James", lastName: "Moriarty", townHallLevel: 10)
                ]
                userMemStore = UserMemStore()
            }
            
            context("when asked to create two users", {
                beforeEach {
                    userMemStore.createUser(user: testUsers[0])
                    userMemStore.createUser(user: testUsers[1])
                }
                
                it("should return same user when fetching first user", closure: {
                    var result: User!
                    userMemStore.fetchUser(id: testUsers[0].id, completionHandler: { (user) in
                        result = user
                    })
                    
                    expect(result).toEventually(equal(testUsers[0]))
                })
                
                it("should return same user when fetching second user", closure:{
                    var result: User!
                    userMemStore.fetchUser(id: testUsers[1].id, completionHandler: { (user) in
                        result = user
                    })
                    
                    expect(result).toEventually(equal(testUsers[1]))
                })
            })

            context("when asked to get a list of users", {
                var resultUsers: [User]!
                beforeEach
                {
                    userMemStore.fetchUsers(completionHandler: { users in
                        resultUsers = users
                    })
                }

                it("should return a list of users", closure: {
                    expect(resultUsers).to(contain(testUsers))
                })
            })
        }
    }
}
