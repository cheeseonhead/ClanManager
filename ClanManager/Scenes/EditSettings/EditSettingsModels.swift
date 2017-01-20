//
//  EditSettingsModels.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-17.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//
//  Type "usecase" for some magic!

import UIKit

struct EditSettings
{
    struct FetchSettings
    {

        struct Request
        {

        }

        struct Response: Equatable
        {
            var currentPlayerTag: String = ""

            static func ==(lhs: Response, rhs: Response) -> Bool
            {
                return lhs.currentPlayerTag == rhs.currentPlayerTag
            }
        }

        struct ViewModel: Equatable
        {
            var currentPlayerTag: String = ""

            static func ==(lhs: ViewModel, rhs: ViewModel) -> Bool
            {
                return lhs.currentPlayerTag == rhs.currentPlayerTag
            }
        }
    }
}
