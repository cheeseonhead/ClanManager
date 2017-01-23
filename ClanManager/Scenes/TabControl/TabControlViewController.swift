//
//  TabControlViewController.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-22.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//

import UIKit

protocol TabControlViewControllerInput
{
    func displaySettings(viewModel: TabControl.FetchSettings.ViewModel)
}

protocol TabControlViewControllerOutput
{
    func fetchSettings(request: TabControl.FetchSettings.Request)
}

protocol TabControlViewControllerRouter: Router
{
    func openSettingsViewController()
    func passDataToViewUserViewController()
}

class TabControlViewController: UITabBarController, TabControlViewControllerInput
{

    var output: TabControlViewControllerOutput!
    var router: TabControlViewControllerRouter!

    // MARK: Object lifecycle

    override func awakeFromNib()
    {
        super.awakeFromNib()
        TabControlConfigurator.sharedInstance.configure(viewController: self)
    }

    // MARK: View lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        fetchSettingsOnLoad()
    }

    // MARK: Display
    func displaySettings(viewModel: TabControl.FetchSettings.ViewModel)
    {
        if viewModel.playerTag.characters.count > 0 {
            router.passDataToViewUserViewController()
        }
        else
        {
            router.openSettingsViewController()
        }
    }
}

fileprivate extension TabControlViewController
{
    func fetchSettingsOnLoad()
    {
        output.fetchSettings(request: TabControl.FetchSettings.Request())
    }
}
