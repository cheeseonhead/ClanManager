//
// Created by Cheese Onhead on 1/16/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

@testable import ClanManager
import Foundation
import Quick
import Nimble

class ViewUserInteractorTests: QuickSpec
{
    override func spec()
    {
        describe("ViewUserInteractor")
        {
            var interactor: ViewUserInteractor!
            var outputSpy: Output!
            var userWorkerSpy: UserWorkerSpy!
            beforeEach
            {
                interactor = ViewUserInteractor()
                outputSpy = Output()
                userWorkerSpy = UserWorkerSpy()

                interactor.output = outputSpy
                interactor.worker = userWorkerSpy
            }

            describe("Fetch User")
            {
                var request = ViewUser.FetchUser.Request(playerTag: "#averyvalidtag")
                var fetchResult = createDefaultUserWorkerFetchResult()

                beforeEach
                {
                    userWorkerSpy.fakeFetchResult = fetchResult
                }

                describe("Request to UserWorker")
                {
                    it("should send request to user worker fetch user")
                    {
                        interactor.fetchUser(request: request)

                        expect(userWorkerSpy.fetchUserCalled).to(beTrue())
                    }

                    it("should pass the tag in request to the user worker")
                    {
                        interactor.fetchUser(request: request)

                        expect(userWorkerSpy.fetchPlayerTagGiven).to(equal(request.playerTag))
                    }
                }

                describe("UserWorker to Output")
                {
                    it("should send response to output")
                    {
                        expect(outputSpy.presentUserCalled).to(beTrue())
                    }

                    it("should have correct first name")
                    {
                        interactor.fetchUser(request: request)

                        let result = outputSpy.presentResponseGiven!
                        let wanted = fetchResult.user!

                        expect(result.firstName).to(equal(wanted.firstName))
                        expect(result.lastName).to(equal(wanted.lastName))
                        expect(result.leagueIconURL).to(equal(wanted.leagueIconURL))
                        expect(result.leagueName).to(equal(wanted.leagueName))
                        expect(result.townHallLevel).to(equal(wanted.townHallLevel))
                        expect(result.trophyCount).to(equal(wanted.trophyCount))
                        expect(result.experienceLevel).to(equal(wanted.experienceLevel))
                    }
                }
            }
        }
    }

    func createDefaultUserWorkerFetchResult() -> UserWorkerFetchResult
    {
        var result = UserWorkerFetchResult()
        result.success = true
        result.user = createDefaultUser()
        return result
    }

    func createDefaultUser() -> User
    {
        var user = User()
        user.playerTag = "#someplayertag"
        user.firstName = "FirstName"
        user.lastName = "LastName"
        user.townHallLevel = 5

        return user
    }
}

fileprivate class Output: ViewUserInteractorOutput
{
    var presentUserCalled = false
    var presentResponseGiven: ViewUser.FetchUser.Response!

    func presentUser(response: ViewUser.FetchUser.Response)
    {
        presentUserCalled = true
        presentResponseGiven = response
    }
}

fileprivate class UserWorkerSpy: UserWorker
{
    var fetchPlayerTagGiven: String!
    var fetchUserCalled = false
    var fakeFetchResult: UserWorkerFetchResult?

    override func fetchUser(playerTag: String, completionHandler: @escaping (_: UserWorkerFetchResult?) -> Void)
    {
        fetchPlayerTagGiven = playerTag
        fetchUserCalled = true
        completionHandler(fakeFetchResult)
    }
}
