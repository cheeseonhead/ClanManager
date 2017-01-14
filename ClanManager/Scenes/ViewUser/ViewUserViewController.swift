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

protocol ViewUserViewControllerInput {
    
}

protocol ViewUserViewControllerOutput {
    func fetchUser(request: ViewUser.FetchUser.Request)
}

class ViewUserViewController: UIViewController, ViewUserViewControllerInput {
    
    var output: ViewUserViewControllerOutput!
    var router: ViewUserRouter!
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    
    // MARK: - Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewUserConfigurator.sharedInstance.configure(viewController: self)
    }
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserOnLoad()
    }
    
    // MARK: - Event handling
    
    func fetchUserOnLoad()
    {
        let request = ViewUser.FetchUser.Request()
        output.fetchUser(request: request)
    }
    
    // MARK: - Display logic
    
}

//This should be on configurator but for some reason storyboard doesn't detect ViewController's name if placed there
extension ViewUserViewController: ViewUserPresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(for: segue)
    }
}
