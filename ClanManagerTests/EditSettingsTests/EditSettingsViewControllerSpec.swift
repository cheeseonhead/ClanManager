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

class EditSettingsViewControllerSpec: QuickSpec
{

    var viewController: EditSettingsViewController!
    var window: UIWindow!

    override func spec()
    {
        describe("EditSettingsViewController")
        {
            var outputSpy: EditSettingsViewControllerOutputSpy!
            beforeEach
            {
                outputSpy = EditSettingsViewControllerOutputSpy()

                self.setupEditSettingsViewController()
                self.viewController.output = outputSpy
            }

            it("should not show status bar")
            {
                expect(self.viewController.prefersStatusBarHidden).to(beTrue())
            }

            context("when view is loaded", {
                beforeEach
                {
                    self.loadView()
                }

                it("should send a request to the output", closure: {
                    expect(outputSpy.fetchSettingsCalled).toEventually(beTrue())
                })
            })

            describe("after view is loaded", closure: {
                beforeEach
                {
                    self.loadView()
                }

                context("when asked to display settings", {
                    var viewModel: EditSettings.FetchSettings.ViewModel!
                    beforeEach
                    {
                        viewModel = EditSettings.FetchSettings.ViewModel(currentPlayerTag: "testingTag")
                        self.viewController.displaySettings(viewModel: viewModel)
                    }

                    it("should display player tag correctly", closure: {
                        expect(self.viewController.playerTagTextField.text).toEventually(equal("testingTag"))
                    })
                })

                context("when text field is tapped")
                {
                    var scrollViewFrame: CGRect!

                    beforeEach
                    {
                        scrollViewFrame = self.viewController.scrollView.frame
                        self.viewController.playerTagTextField.becomeFirstResponder()
                    }

                    it("should do something")
                    {
                        expect(self.viewController.scrollView.frame.size.height).toEventually(beLessThan(scrollViewFrame.size.height))
                    }
                }

                context("when save button is tapped, with valid info")
                {
                    beforeEach
                    {
                        self.viewController.playerTagTextField.text = "validPlayerTagRightHere"
                        self.viewController.saveButtonPressed(self.viewController.saveButton)
                    }

                    it("should send a request to the output")
                    {
                        expect(outputSpy.storeSettingsCalled).toEventually(beTrue())
                    }

                    it("should send a correct request to the output")
                    {
                        let expected = EditSettings.StoreSettings.Request(playerTag: "validPlayerTagRightHere")
                        expect(outputSpy.gotStoreSettingsRequest).toEventually(equal(expected))
                    }
                }
            })

            afterEach
            {
                self.window = nil
            }
        }
    }

    // MARK: Helpers
    func setupEditSettingsViewController()
    {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "EditSettings", bundle: bundle)
        viewController = storyboard.instantiateViewController(withIdentifier: "EditSettingsViewController") as! EditSettingsViewController
    }

    func loadView()
    {
        window = UIWindow()
        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }
}

fileprivate class EditSettingsViewControllerOutputSpy: EditSettingsViewControllerOutput
{
    // Checkers
    var fetchSettingsCalled = false
    var storeSettingsCalled = false
    var gotStoreSettingsRequest: EditSettings.StoreSettings.Request!

    func fetchSettings(request _: EditSettings.FetchSettings.Request)
    {
        fetchSettingsCalled = true
    }

    func storeSettings(request: EditSettings.StoreSettings.Request)
    {
        storeSettingsCalled = true
        gotStoreSettingsRequest = request
    }
}
