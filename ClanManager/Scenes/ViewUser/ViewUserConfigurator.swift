//
//  ViewUserConfigurator.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-13.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension ViewUserViewController: ViewUserPresenterOutput
{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        router.passDataToNextScene(for: segue)
    }
}

extension ViewUserInteractor: ViewUserViewControllerOutput, ViewUserRouterDataSource, ViewUserRouterDataDestination
{
}

extension ViewUserPresenter: ViewUserInteractorOutput
{
}

extension ViewUserRouter:ViewUserRouterOutput {}

class ViewUserConfigurator
{
    // MARK: Object lifecycle

    static let sharedInstance = ViewUserConfigurator()

    private init() {}

    // MARK: Configuration

    func configure(viewController: ViewUserViewController)
    {

        let presenter = ViewUserPresenter()
        presenter.output = viewController

        let interactor = ViewUserInteractor()
        interactor.output = presenter

        let router = ViewUserRouter(viewController: viewController, dataSource: interactor, dataDestination: interactor)

        viewController.output = interactor
        viewController.router = router
    }
}
