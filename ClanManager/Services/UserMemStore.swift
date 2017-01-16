//
// Created by Jeffrey Wu on 2017-01-14.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol UserMemStoreInput
{
    func fetchUser(completionHandler: @escaping (_: User) -> Void)
    func fetchUsers(completionHandler: @escaping (_: [User]) -> Void)
}

class UserMemStore : UserMemStoreInput
{
    var users: [User]!
    
    func fetchUsers(completionHandler: @escaping (_: [User]) -> Void)
    {
        
    }
    
    func fetchUser(completionHandler: @escaping (_: User) -> Void) {

    }
}
