//
//  ViewUserInteractor.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-13.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//

import UIKit

protocol ViewUserInteractorInput
{
    func fetchUser(request _: ViewUser.FetchUser.Request)
}

protocol ViewUserInteractorOutput
{
    func presentUser(response: ViewUser.FetchUser.Response)
}

protocol ViewUserDataProvider {}

protocol ViewUserDataReceiver
{
    var playerTag: String! { get set }
}

class ViewUserInteractor: ViewUserInteractorInput, ViewUserDataProvider, ViewUserDataReceiver
{

    var output: ViewUserInteractorOutput!
    var worker: UserWorker! = UserWorker()

    var playerTag: String! {
        didSet
        {
            self.fetchUserWith(id: playerTag)
        }
    }

    // MARK: Business logic

    func fetchUser(request: ViewUser.FetchUser.Request)
    {
        self.fetchUserWith(id: request.playerTag)
    }
}

fileprivate extension ViewUserInteractor
{
    func fetchUserWith(id: String)
    {
        worker.fetchUser(playerTag: id, completionHandler: { result in
            guard result.success else
            {
                return
            }

            let response = self.convertUserIntoResponse(user: result.user!)

            self.output.presentUser(response: response)
        })
    }
}

fileprivate extension ViewUserInteractor
{
    func convertUserIntoResponse(user: User) -> ViewUser.FetchUser.Response
    {
        var response = ViewUser.FetchUser.Response()
        response.firstName = user.firstName
        response.lastName = user.lastName
        response.leagueName = user.leagueName
        response.experienceLevel = user.experienceLevel
        response.trophyCount = user.trophyCount
        response.townHallLevel = user.townHallLevel
        response.leagueIconURL = user.leagueIconURL

        return response
    }
}
