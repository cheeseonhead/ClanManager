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
    func storeSettings(settingsToStore: Settings, completionHandler: @escaping (SessionStore.UpdateResult) -> Void)
}

class SessionMemStore: SessionMemStoreInput
{
    static var sharedInstance = SessionMemStore()
    var currentSettings: Settings!

    func fetchSettings(completionHandler: @escaping (Settings?) -> Void)
    {
        completionHandler(currentSettings)
    }

    func storeSettings(settingsToStore: Settings, completionHandler: @escaping (SessionStore.UpdateResult) -> Void)
    {
        currentSettings = settingsToStore

        let result = SessionStore.UpdateResult(success: true)
        completionHandler(result)
    }
}
