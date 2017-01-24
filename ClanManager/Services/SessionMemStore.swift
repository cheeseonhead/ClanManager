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
    func saveSettings(newSettings: Settings, completionHandler: @escaping (Settings?) -> Void)
}

class SessionMemStore: SessionMemStoreInput
{
    var currentSettings: Settings! = Settings(currentPlayerTag: "jeff")

    func fetchSettings(completionHandler: @escaping (Settings?) -> Void)
    {
        completionHandler(currentSettings)
    }

    func saveSettings(newSettings: Settings, completionHandler: @escaping (Settings?) -> Void)
    {
        currentSettings = newSettings
        completionHandler(currentSettings)
    }
}
