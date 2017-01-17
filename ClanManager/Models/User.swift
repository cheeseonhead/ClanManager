//
// Created by Jeffrey Wu on 2017-01-13.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct User: Equatable {
    var name: String = ""
    var townHallLevel: Int = 0
    
    static func ==(lhs: User, rhs: User) -> Bool
    {
        if(lhs.name != rhs.name) {
            return false
        }
        if(lhs.townHallLevel != rhs.townHallLevel) {
            return false
        }
        return true
    }
}
