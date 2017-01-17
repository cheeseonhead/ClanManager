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
            beforeEach
            {
                interactor = ViewUserInteractor()
            }

            context("when asked to fetch user", {
                beforeEach
                {
                    interactor.fetchUser(id: "thisIdNonExist", request: ViewUser.FetchUser.Request())
                }
            })
        }
    }
}
