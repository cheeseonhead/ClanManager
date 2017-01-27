//
//  SessionStoreProtocol.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-27.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct SessionStore
{
    struct UpdateResult
    {
        var success: Bool = true
    }
}

protocol SessionStoreProtocol
{
    func fetchSettings(completionHandler _: @escaping (Settings?) -> Void)
    func storeSettings(settingsToStore: Settings, completionHandler _: @escaping (Bool, Settings?) -> Void)
}
