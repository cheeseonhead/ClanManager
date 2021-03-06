//
//  TabControlRouter.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-22.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//

import UIKit

protocol TabControlRouterInput
{
    func openSettingsViewController()
    func passDataToViewUserViewController()
}

protocol TabControlRouterDataProvider: class
{
    var currentPlayerTag: String? { get }
}

protocol TabControlRouterDataReceiver: class {}

class TabControlRouter: TabControlRouterInput
{
    // View Controllers
    weak var tabControlVC: UIViewController!
    weak var viewUserVC: ViewUserViewController!

    private weak var dataSource: TabControlRouterDataProvider!
    weak var dataDestination: TabControlRouterDataReceiver!

    init(viewController: UIViewController, dataSource: TabControlRouterDataProvider, dataDestination: TabControlRouterDataReceiver)
    {
        self.tabControlVC = viewController
        self.dataSource = dataSource
        self.dataDestination = dataDestination
    }

    // MARK: Navigation

    func openSettingsViewController()
    {
        tabControlVC.performSegue(withIdentifier: "presentEditSettingsViewController", sender: nil)
    }

    // MARK: Communication

    func passDataToViewUserViewController()
    {
        viewUserVC.dataReceiver.playerTag = dataSource.currentPlayerTag
    }
}
