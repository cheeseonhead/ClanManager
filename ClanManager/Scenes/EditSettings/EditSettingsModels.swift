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

    struct StoreSettings
    {
        struct Request: Equatable
        {
            var playerTag: String = ""

            static func ==(lhs: Request, rhs: Request) -> Bool
            {
                return lhs.playerTag == rhs.playerTag
            }
        }

        enum StringValidationType
        {
            case valid
            case empty
            case containsSpaces
        }

        struct Response: Equatable
        {
            var success: Bool = true
            var playerTagValidation = StringValidationType.valid

            static func ==(lhs: Response, rhs: Response) -> Bool
            {
                return lhs.success == rhs.success &&
                    lhs.playerTagValidation == rhs.playerTagValidation
            }
        }

        struct ViewModel
        {
            var isReadyToNavigate: Bool = false
        }
    }
}
