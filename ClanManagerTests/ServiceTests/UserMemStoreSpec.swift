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
                    User(playerTag: "#jeffwu", firstName: "Jeff", lastName: "Woo", townHallLevel: 10,
                         experienceLevel: 182, leagueIconURL: nil, leagueName: "Gold II", trophyCount: 1992),
                    User(playerTag: "#tracyyang", firstName: "Tracy", lastName: "Yang", townHallLevel: 5,
                         experienceLevel: 88, leagueIconURL: nil, leagueName: "Crystal II", trophyCount: 2193),
                ]
                userMemStore = UserMemStore()
            }

            describe("create two users", {
                beforeEach
                {
                    userMemStore.createUser(user: testUsers[0])
                    userMemStore.createUser(user: testUsers[1])
                }

                context("when asked to fetch those two users", {
                    it("should return same user when fetching first user", closure: {
                        var result: User!
                        userMemStore.fetchUser(id: testUsers[0].playerTag, completionHandler: { user in
                            result = user
                        })

                        expect(result).toEventually(equal(testUsers[0]))
                    })

                    it("should return same user when fetching second user", closure: {
                        var result: User!
                        userMemStore.fetchUser(id: testUsers[1].playerTag, completionHandler: { user in
                            result = user
                        })

                        expect(result).toEventually(equal(testUsers[1]))
                    })
                })

                context("when asked to fetch a user that doesn't exist", {
                    it("should return a nil user", closure: {
                        var result: User? = testUsers[0]
                        userMemStore.fetchUser(id: "idDoesntExist", completionHandler: { user in
                            result = user
                        })

                        expect(result).toEventually(beNil())
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
            })
        }
    }
}
