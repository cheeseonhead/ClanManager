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
    var worker: UserWorker! = UserWorker(userStore: UserMemStore())

    var playerTag: String! {
        didSet
        {
            self.fetchUserWith(Id: playerTag)
        }
    }

    // MARK: Business logic

    func fetchUser(request: ViewUser.FetchUser.Request)
    {
        self.fetchUserWith(Id: request.id)
    }
}

fileprivate extension ViewUserInteractor
{
    func fetchUserWith(Id id: String)
    {
        worker.fetchUser(id: id, completionHandler: { user in
            guard let user = user else
            {
                self.output.presentUser(response: ViewUser.FetchUser.Response())
                return
            }
            let response = ViewUser.FetchUser.Response()
            self.output.presentUser(response: response)
        })
    }
}

extension UserMemStore: UserStoreProtocol {}
