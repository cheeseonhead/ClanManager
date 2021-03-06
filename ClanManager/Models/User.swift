//
// Created by Jeffrey Wu on 2017-01-13.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct User: Equatable
{
    var id: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var townHallLevel: Int = 0

    static func ==(lhs: User, rhs: User) -> Bool
    {
        return lhs.id == rhs.id
    }
}
