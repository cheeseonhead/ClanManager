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
                userWorkerSpy = UserWorkerSpy(userStore: UserMemStore())

                interactor.output = outputSpy
                interactor.worker = userWorkerSpy
            }

            context("Fetch User")
            {
                var request = ViewUser.FetchUser.Request(playerTag: "#averyvalidtag")

                it("should send request to user worker fetch user")
                {
                    interactor.fetchUser(request: request)

                    userWorkerSpy.
                }
            }
        }
    }
}

fileprivate class Output: ViewUserInteractorOutput
{
    var presentUserCalled = false
    var resultResponse: ViewUser.FetchUser.Response!

    func presentUser(response: ViewUser.FetchUser.Response)
    {
        presentUserCalled = true
        resultResponse = response
    }
}

fileprivate class UserWorkerSpy: UserWorker
{
    var fetchPlayerTagGiven: String!
    var fetchUserCalled = false
    var fetchResultGiven: UserWorkerFetchResult?

    override func fetchUser(playerTag: String, completionHandler: @escaping (_: UserWorkerFetchResult?) -> Void)
    {
        fetchPlayerTagGiven = playerTag
        fetchUserCalled = true
        completionHandler(fetchResultGiven)
    }
}
