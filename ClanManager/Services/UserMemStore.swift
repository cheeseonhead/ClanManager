//
// Created by Jeffrey Wu on 2017-01-14.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol UserMemStoreInput
{
    func fetchUser(completionHandler: @escaping (_: User) -> Void)
}

class UserMemStore : UserMemStoreInput
{
    func fetchUser(completionHandler: @escaping (_: User) -> Void) {

    }
}
