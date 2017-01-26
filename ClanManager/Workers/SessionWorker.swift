//
//  SessionWorker.swift
//  ClanManager
//
//  Created by Cheese Onhead on 1/18/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import UIKit

protocol SessionStoreProtocol
{
    func fetchSettings(completionHandler _: @escaping (Settings?) -> Void)
    func storeSettings(settingsToStore: Settings, completionHandler _: @escaping (Bool, Settings?) -> Void)
}

struct StoreSettingsResult
{
    var success: Bool = true
    var playerTagValidation: SettingsStringValidation
}

class SessionWorker
{
    var store: SessionStoreProtocol!

    init(store: SessionStoreProtocol)
    {
        self.store = store
    }

    func fetchSettings(completionHandler: @escaping (_: Settings?) -> Void)
    {
        store.fetchSettings
        { settings in
            completionHandler(settings)
        }
    }

    func storeSettings(settingsToStore: Settings, completionHandler _: @escaping (Settings?) -> Void)
    {

    }
}
