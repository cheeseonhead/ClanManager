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
            var outputSpy: OutputSpy!
            var routerSpy: RouterSpy!

            beforeEach
            {
                outputSpy = OutputSpy()
                routerSpy = RouterSpy()

                self.setupViewController()
                self.viewController.output = outputSpy
                self.viewController.router = routerSpy
            }

            context("when view is loaded")
            {
                beforeEach
                {
                    self.loadView()
                }

                it("should send request to load settings to output")
                {
                    expect(outputSpy.fetchSettingsCalled).toEventually(beTrue())
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
                        let viewModel = TabControl.FetchSettings.ViewModel(playerTag: "")
                        self.viewController.displaySettings(viewModel: viewModel)
                    }

                    it("should ask the router to navigate to edit settings scene")
                    {
                        expect(routerSpy.openSettingsCalled).toEventually(beTrue())
                    }
                }

                context("when asked to display settings with non-empty player tag")
                {
                    beforeEach
                    {
                        let viewModel = TabControl.FetchSettings.ViewModel(playerTag: "nonEmptyPlayerTag")
                        self.viewController.displaySettings(viewModel: viewModel)
                    }

                    it("should ask the router to pass data to the view user scene")
                    {
                        expect(routerSpy.passDataToViewUserCalled).toEventually(beTrue())
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

fileprivate class OutputSpy: TabControlViewControllerOutput
{
    // Checks
    var fetchSettingsCalled = false

    func fetchSettings(request _: TabControl.FetchSettings.Request)
    {
        fetchSettingsCalled = true
    }
}

fileprivate class RouterSpy: TabControlViewControllerRouter
{
    // Checks
    var openSettingsCalled = false
    var passDataToViewUserCalled = false

    func openSettingsViewController()
    {
        openSettingsCalled = true
    }

    func passDataToViewUserViewController()
    {
        passDataToViewUserCalled = true
    }

    func passDataToNextScene(for segue: UIStoryboardSegue) {}
}
