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

}

protocol TabControlViewControllerOutput
{

}

class TabControlViewController: UIViewController, TabControlViewControllerInput
{

    var output: TabControlViewControllerOutput!
    var router: TabControlRouter!

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
    }

    // MARK: Event handling

    // MARK: Display logic

}

// This should be on configurator but for some reason storyboard doesn't detect ViewController's name if placed there
extension TabControlViewController: TabControlPresenterOutput
{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        router.passDataToNextScene(for: segue)
    }
}
