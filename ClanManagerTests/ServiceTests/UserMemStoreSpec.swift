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
            }
        }
    }
}
