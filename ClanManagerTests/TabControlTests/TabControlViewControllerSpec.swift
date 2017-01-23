//
//  TabControlViewControllerSpec.swift
//  ClanManager
//
//  Created by Cheese Onhead on 1/22/17.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Quick
import Nimble
@testable import ClanManager

class TabControlViewControllerSpec: QuickSpec
{
    var viewController: TabControlViewController!
    var window: UIWindow!

    override func spec()
    {
        describe("TabControlViewController")
        {
            beforeEach
            {
                self.setupViewController()
            }

            context("when view is loaded")
            {
                beforeEach
                {
                    self.loadView()
                }

                it("should send request to load settings to output")
                {
                    expect(false).to(beTrue())
                }
            }

            describe("after view is loaded")
            {
                beforeEach
                {
                    self.loadView()
                }

                context("when asked to display settings with empty player tag")
                {
                    beforeEach
                    {
                        // Ask to display settings
                    }

                    it("should ask the router to navigate to edit settings scene")
                    {
                        expect(false).to(beTrue())
                    }
                }

                context("when asked to display settings with non-empty player tag")
                {
                    beforeEach
                    {
                        // Ask to display
                    }

                    it("should ask the router to pass data to the view user scene")
                    {
                        expect(false).to(beTrue())
                    }
                }
            }
        }
    }

    // MARK: Helpers
    func setupViewController()
    {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        viewController = storyboard.instantiateViewController(withIdentifier: "TabControlViewController") as! TabControlViewController
    }

    func loadView()
    {
        window = UIWindow()
        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }
}
