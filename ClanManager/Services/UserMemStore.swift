//
// Created by Jeffrey Wu on 2017-01-14.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol UserMemStoreInput
{
    func fetchUsers(completionHandler: @escaping (_: [User]) -> Void)
    func fetchUser(id: String, completionHandler: @escaping (_: User) -> Void)
}

class UserMemStore: UserMemStoreInput
{
    var users: [User]!

    func fetchUsers(completionHandler: @escaping (_: [User]) -> Void)
    {
        completionHandler(users)
    }

    func fetchUser(id _: String, completionHandler _: @escaping (_: User) -> Void)
    {

    }
}
