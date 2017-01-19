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
    func fetchSettings(completionHandler _: @escaping (Settings?) -> Void)
    {

    }

    func saveSettings(newSettings _: Settings, completionHandler _: @escaping (Settings?) -> Void)
    {

    }
}
