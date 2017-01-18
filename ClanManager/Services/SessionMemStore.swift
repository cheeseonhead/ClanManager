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
    func fetchSettings(completionHandler:(Settings?)->Void)
}

class SessionMemStore : SessionMemStoreInput
{
    func fetchSettings(completionHandler: (Settings?) -> Void) {
        
    }
}
