//
// Created by Jeffrey Wu on 2017-01-14.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class UserWorker {
    func fetchUser(completionHandler:(_:User)->Void) {
        let user = User()
        completionHandler(user)
    }
}