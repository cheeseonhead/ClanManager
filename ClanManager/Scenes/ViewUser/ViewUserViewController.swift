//
//  ViewUserViewController.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-13.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//

import UIKit

protocol ViewUserViewControllerInput
{
    func displayUser(viewModel: ViewUser.FetchUser.ViewModel)
}

protocol ViewUserViewControllerOutput
{
    func fetchUser(request _: ViewUser.FetchUser.Request)
}

protocol ViewUserViewControllerRouter {}

class ViewUserViewController: UIViewController, ViewUserViewControllerInput
{

    var output: ViewUserViewControllerOutput!
    var router: ViewUserViewControllerRouter!
    var dataReceiver: ViewUserRouterDataReceiver!

    // MARK: - Outlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var leagueIconImage: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var trohpiesLabel: UILabel!

    // MARK: - Object lifecycle

    override func awakeFromNib()
    {
        super.awakeFromNib()
        ViewUserConfigurator.sharedInstance.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        fetchUserOnLoad()
    }

    // MARK: - Event handling

    func fetchUserOnLoad()
    {
        let request = ViewUser.FetchUser.Request(id: "")
        output.fetchUser(request: request)
    }

    // MARK: - Display logic

    func displayUser(viewModel: ViewUser.FetchUser.ViewModel)
    {
        nameLabel.text = viewModel.name
        infoLabel.text = viewModel.info
    }
}

extension ViewUserViewController
{
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
}
