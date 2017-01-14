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

protocol ViewUserInteractorInput {
    func fetchUser(request: ViewUser.FetchUser.Request)
}

protocol ViewUserInteractorOutput {
    func presentUser(response: ViewUser.FetchUser.Response)
}

protocol ViewUserDataSource {
    
}

protocol ViewUserDataDestination {
    
}

class ViewUserInteractor: ViewUserInteractorInput, ViewUserDataSource, ViewUserDataDestination {
    
    var output: ViewUserInteractorOutput!
    var worker: UserWorker! = UserWorker(userStore: UserMemStore())
    
    // MARK: Business logic
    
    func fetchUser(request: ViewUser.FetchUser.Request)
    {
        worker.fetchUser(completionHandler: { (user:User) -> Void in
            let response = ViewUser.FetchUser.Response()
            output.presentUser(response: response)
        })
    }
}
