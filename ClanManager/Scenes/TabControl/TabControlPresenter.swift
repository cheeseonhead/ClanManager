//
//  TabControlPresenter.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-22.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//

import UIKit

protocol TabControlPresenterInput
{
    func presentSettings(response: TabControl.FetchSettings.Response)
}

protocol TabControlPresenterOutput: class
{
    func displaySettings(viewModel: TabControl.FetchSettings.ViewModel)
}

class TabControlPresenter: TabControlPresenterInput
{
    weak var output: TabControlPresenterOutput!

    // MARK: Presentation logic

    func presentSettings(response _: TabControl.FetchSettings.Response) {}
}
