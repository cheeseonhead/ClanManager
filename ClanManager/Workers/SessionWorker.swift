//
//  SessionWorker.swift
//  ClanManager
//
//  Created by Cheese Onhead on 1/18/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import UIKit

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

    func storeSettings(settingsToStore: Settings, completionHandler: @escaping (StoreSettingsResult) -> Void)
    {
        var result = StoreSettingsResult()

        if settingsToStore.currentPlayerTag.characters.index(of: " ") != nil
        {
            result.success = false
            result.playerTagValidation = .errorContainsSpaces
        }
        else if settingsToStore.currentPlayerTag.characters.count == 0 {
            result.success = false
            result.playerTagValidation = .errorEmpty
        }

        guard result.success == true else
        {
            completionHandler(result)
            return
        }

        store.storeSettings(settingsToStore: settingsToStore)
        { updateResult in
            result.success = updateResult.success

            completionHandler(result)
        }
    }
}
