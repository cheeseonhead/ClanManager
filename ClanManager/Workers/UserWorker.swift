//
// Created by Jeffrey Wu on 2017-01-14.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct UserWorkerFetchResult
{
    var success: Bool = false
    var user: User?
}

class UserWorker
{
    private var users: [String: User] = [
        "jeff": User(playerTag: "#jeffwu", firstName: "Jeff", lastName: "Woo", townHallLevel: 10,
                     experienceLevel: 182, leagueIconURL: nil, leagueName: "Gold II", trophyCount: 1992),
        "tracy": User(playerTag: "#tracyyang", firstName: "Tracy", lastName: "Yang", townHallLevel: 5,
                      experienceLevel: 88, leagueIconURL: nil, leagueName: "Crystal II", trophyCount: 2193),
    ]

    func fetchUser(playerTag: String, completionHandler: @escaping (_: UserWorkerFetchResult?) -> Void)
    {
        var result = UserWorkerFetchResult()

        result.success = true
        result.user = users[playerTag]

        completionHandler(result)
    }
}
