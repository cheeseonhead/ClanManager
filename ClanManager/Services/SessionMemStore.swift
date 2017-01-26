//
//  SessionMemStore.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-18.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol SessionMemStoreInput
{
    // Read
    func fetchSettings(completionHandler _: @escaping (Settings?) -> Void)

    // Update
    func storeSettings(settingsToStore: Settings, completionHandler _: @escaping (Bool, Settings?) -> Void)
}

class SessionMemStore: SessionMemStoreInput
{
    var currentSettings: Settings! = Settings(currentPlayerTag: "jeff")

    func fetchSettings(completionHandler: @escaping (Settings?) -> Void)
    {
        completionHandler(currentSettings)
    }

    func storeSettings(settingsToStore: Settings, completionHandler: @escaping (Bool, Settings?) -> Void)
    {
        currentSettings = settingsToStore
        completionHandler(true, currentSettings)
    }
}
