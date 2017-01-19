//
//  Settings.swift
//  ClanManager
//
//  Created by Cheese Onhead on 1/18/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

struct Settings: Equatable
{
    var currentPlayerTag: String = ""

    static func ==(lhs: Settings, rhs: Settings) -> Bool
    {
        return lhs.currentPlayerTag == rhs.currentPlayerTag
    }
}
