//
// Created by Jeffrey Wu on 2017-01-14.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol UserMemStoreInput
{
    // Create
    func createUser(user: User)

    // Read
    func fetchUsers(completionHandler: @escaping (_: [User]) -> Void)
    func fetchUser(id: String, completionHandler: @escaping (_: User?) -> Void)
}

class UserMemStore: UserMemStoreInput
{
    private var users: [String: User] = [
        "jeff": User(id: "jeff", firstName: "Jeff", lastName: "Woo", townHallLevel: 10),
        "tracy": User(id: "tracy", firstName: "Tracy", lastName: "Yang", townHallLevel: 5),
    ]

    func createUser(user: User)
    {
        users[user.id] = user
    }

    func fetchUsers(completionHandler: @escaping (_: [User]) -> Void)
    {
        completionHandler(users.map({ (_, user) -> User in
            return user
        }))
    }

    func fetchUser(id: String, completionHandler: @escaping (_: User?) -> Void)
    {
        completionHandler(users[id])
    }
}
