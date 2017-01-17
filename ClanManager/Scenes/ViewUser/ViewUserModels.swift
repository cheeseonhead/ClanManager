//
//  ViewUserModels.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-13.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//
//  Type "usecase" for some magic!

import UIKit

struct ViewUser
{
    struct FetchUser
    {

        struct Request: Equatable
        {
            var id: String

            static func ==(lhs: Request, rhs: Request) -> Bool
            {
                return lhs.id == rhs.id
            }
        }

        struct Response: Equatable
        {
            var firstName: String = ""
            var lastName: String = ""
            var townHallLevel: Int = 0

            static func ==(lhs: Response, rhs: Response) -> Bool
            {
                return lhs.firstName == rhs.firstName &&
                    lhs.lastName == rhs.lastName &&
                    lhs.townHallLevel == rhs.townHallLevel
            }
        }

        struct ViewModel
        {
            var name: String
            var info: String
        }
    }
}
