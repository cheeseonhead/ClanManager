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
}

class SessionWorker
{
    var store:SessionStoreProtocol!
    
    init(store:SessionStoreProtocol) {
        self.store = store
    }
    
    func fetchSettings(completionHandler _: @escaping (_: Settings?) -> Void)
    {

    }
}
