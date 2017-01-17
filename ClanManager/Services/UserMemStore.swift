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
    private var users: [String:User] = [:]

    func createUser(user: User) {
        users[user.id] = user
    }
    
    func fetchUsers(completionHandler: @escaping (_: [User]) -> Void)
    {
        completionHandler(users.map({ (key, user) -> User in
            return user
        }))
    }

    func fetchUser(id: String, completionHandler: @escaping (_: User?) -> Void)
    {
        completionHandler(users[id])
    }
}
