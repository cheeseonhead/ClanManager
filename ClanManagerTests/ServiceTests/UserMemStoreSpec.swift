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
            let userMemStore:UserMemStore!
            beforeEach {
                userMemStore = UserMemStore()
            }
        }
    }
}
