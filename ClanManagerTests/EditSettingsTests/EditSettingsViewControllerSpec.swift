//
//  EditSettingsViewControllerSpec.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

@testable import ClanManager
import Quick
import Nimble

class EditSettingsViewControllerSpec: QuickSpec {
    
    var viewController: EditSettingsViewController!
    var window: UIWindow!
    
    override func spec() {
        describe("EditSettingsViewController") {
            beforeEach {
                self.setupEditSettingsViewController()
            }
        }
    }
    
    // MARK: Helpers
    func setupEditSettingsViewController()
    {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        viewController = storyboard.instantiateViewController(withIdentifier: "EditSettingsViewController") as! EditSettingsViewController
    }
    
    func loadView()
    {
        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }
}
