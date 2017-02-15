//
// Created by Jeffrey Wu on 2017-01-13.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct User: Equatable
{
    var playerTag: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var townHallLevel: Int = 0
    var experienceLevel: Int = 0
    var leagueIconURL: String?
    var leagueName: String = ""
    var trophyCount: Int = 0

    public static func ==(lhs: User, rhs: User) -> Bool
    {
        return lhs.playerTag == rhs.playerTag
            && lhs.firstName == rhs.firstName
            && lhs.lastName == rhs.lastName
            && lhs.townHallLevel == rhs.townHallLevel
    }
}
