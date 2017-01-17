//
// Created by Jeffrey Wu on 2017-01-14.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol UserStoreProtocol
{
    func fetchUser(id: String, completionHandler: @escaping (_: User) -> Void)
}

class UserWorker
{
    var userStore: UserStoreProtocol

    init(userStore: UserStoreProtocol)
    {
        self.userStore = userStore
    }

    func fetchUser(id: String, completionHandler: @escaping (_: User) -> Void)
    {
        userStore.fetchUser(id: id)
        { user in
            completionHandler(user)
        }
    }
}
