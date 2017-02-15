//
// Created by Jeffrey Wu on 2017-01-14.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class UserWorker
{
    private var users: [String: User] = [
        "jeff": User(id: "jeff", firstName: "Jeff", lastName: "Woo", townHallLevel: 10),
        "tracy": User(id: "tracy", firstName: "Tracy", lastName: "Yang", townHallLevel: 5),
    ]

    func fetchUser(id _: String, completionHandler _: @escaping (_: User?) -> Void)
    {

    }
}
