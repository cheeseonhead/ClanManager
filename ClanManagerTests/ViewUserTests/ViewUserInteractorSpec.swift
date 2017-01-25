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

                interactor.output = interactorSpy
                interactor.worker = userWorkerSpy
            }

            context("when asked to fetch user", {
                beforeEach
                {
                    userWorkerSpy.fakeResultUser = User(id: "thisIdExists", firstName: "Allen", lastName: "Chan", townHallLevel: 5)

                    interactor.fetchUser(request: ViewUser.FetchUser.Request(id: "barryAllen321"))
                }

                it("should trigger present user on output", closure: {
                    expect(interactorSpy.presentUserCalled).toEventually(beTrue())
                })

                it("should request for the user with correct id from request", closure: {
                    expect(userWorkerSpy.requestID).toEventually(equal("barryAllen321"))
                })

                it("should correctly create response with valid return user", closure: {
                    let expected = ViewUser.FetchUser.Response(firstName: userWorkerSpy.fakeResultUser!.firstName,
                                                               lastName: userWorkerSpy.fakeResultUser!.lastName,
                                                               townHallLevel: userWorkerSpy.fakeResultUser!.townHallLevel)
                    expect(interactorSpy.resultResponse).toEventually(equal(expected))
                })
            })

            context("when asked to fetch invalid user", {
                beforeEach
                {
                    userWorkerSpy.fakeResultUser = nil

                    interactor.fetchUser(request: ViewUser.FetchUser.Request(id: ""))
                }

                it("should create valid response", closure: {
                    let expected = ViewUser.FetchUser.Response()
                    expect(interactorSpy.resultResponse).toEventually(equal(expected))
                })
            })

            context("when player tag is set")
            {
                beforeEach
                {
                    interactor.playerTag = "playerTag"
                }

                it("should send request to worker")
                {
                    expect(userWorkerSpy.fetchUserCalled).toEventually(beTrue())
                }

                it("should send correct request to worker")
                {
                    expect(userWorkerSpy.requestID).toEventually(equal("playerTag"))
                }
            }
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
    var fakeResultUser: User?

    override func fetchUser(id: String, completionHandler: @escaping (_: User?) -> Void)
    {
        requestID = id
        fetchUserCalled = true
        completionHandler(fakeResultUser)
    }
}
