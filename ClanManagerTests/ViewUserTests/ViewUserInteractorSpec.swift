//
// Created by Cheese Onhead on 1/16/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

@testable import ClanManager
import Foundation
import Quick
import Nimble

class ViewUserInteractorSpec: QuickSpec
{
    override func spec()
    {
        describe("ViewUserInteractor")
        {
            var interactor: ViewUserInteractor!
            var interactorSpy: ViewUserInteractorSpy!
            var userWorkerSpy: UserWorkerSpy!
            beforeEach
            {
                interactor = ViewUserInteractor()
                interactorSpy = ViewUserInteractorSpy()
                userWorkerSpy = UserWorkerSpy(userStore: UserMemStore())

                userWorkerSpy.fakeResultUser = User(id: "thisIdExists", firstName: "Allen", lastName: "Chan", townHallLevel: 5)

                interactor.output = interactorSpy
                interactor.worker = userWorkerSpy
            }

            context("when asked to fetch user", {
                beforeEach
                {
                    interactor.fetchUser(id: "thisIdNonExist", request: ViewUser.FetchUser.Request())
                }

                it("should trigger present user on output", closure: {
                    expect(interactorSpy.presentUserCalled).toEventually(beTrue())
                })

                it("should request for the user with correct id from request", closure: {
                })
            })
        }
    }
}

fileprivate class ViewUserInteractorSpy: ViewUserInteractorOutput
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
    var requestID: String!
    var fetchUserCalled = false
    var fakeResultUser: User!

    override func fetchUser(id: String, completionHandler: @escaping (_: User) -> Void)
    {
        requestID = id
        fetchUserCalled = true
        completionHandler(fakeResultUser)
    }
}
