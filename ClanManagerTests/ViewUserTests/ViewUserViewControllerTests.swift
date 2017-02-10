//
//  ViewUserViewControllerTests.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-13.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

@testable import ClanManager
import XCTest
import Quick
import Nimble

class ViewUserViewControllerTests: QuickSpec
{
    override func spec()
    {
        var viewController: ViewUserViewController!
        var outputSpy: OutputSpy!
        var window: UIWindow!

        beforeEach
        {
            window = UIWindow()
            outputSpy = OutputSpy()
            viewController = self.createViewController()
            viewController.output = outputSpy

            self.loadView(window: window, viewController: viewController)
        }

        describe("Event Load")
        {
            it("should have dispatched a request to output")
            {
                expect(outputSpy.fetchUserCalled).to(beTrue())
            }
        }

        describe("Display Fetch User")
        {
            var defaultViewModel = ViewUser.FetchUser.ViewModel()

            describe("Name Label")
            {
                it("should have same text as view model")
                {
                    defaultViewModel.name = "Just a test name"

                    viewController.displayUser(viewModel: defaultViewModel)

                    expect(viewController.nameLabel.text).to(equal(defaultViewModel.name))
                }
            }

            describe("Town Hall Label")
            {
                it("should have same text as view model")
                {
                    defaultViewModel.townHallDescription = "Toooooooownhall 10"

                    viewController.displayUser(viewModel: defaultViewModel)

                    expect(viewController.townHallLabel.text).to(equal(defaultViewModel.townHallDescription))
                }
            }

            describe("Experience Label")
            {
                it("should have the same text as view model")
                {
                    defaultViewModel.experience = "128"

                    viewController.displayUser(viewModel: defaultViewModel)

                    expect(viewController.experienceLabel.text).to(equal(defaultViewModel.experience))
                }
            }

            describe("League Icon")
            {
                it("should have the same image as the view model")
                {
                    defaultViewModel.leagueIcon = UIImage()

                    viewController.displayUser(viewModel: defaultViewModel)

                    expect(viewController.leagueIconImage.image).to(equal(defaultViewModel.leagueIcon))
                }
            }

            describe("League Name")
            {
                it("should have the same text as the view model")
                {
                    defaultViewModel.leagueName = "Gold II"

                    viewController.displayUser(viewModel: defaultViewModel)

                    expect(viewController.leagueNameLabel.text).to(equal(defaultViewModel.leagueName))
                }
            }

            describe("Trophies Label")
            {
                it("should have the same text as the view model")
                {
                    defaultViewModel.trophyDescription = "Trohpies: 12392"

                    viewController.displayUser(viewModel: defaultViewModel)

                    expect(viewController.trophiesLabel.text).to(equal(defaultViewModel.trophyDescription))
                }
            }
        }
    }

    func createViewController() -> ViewUserViewController
    {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "ViewUser", bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: "ViewUserViewController") as! ViewUserViewController
    }

    func loadView(window: UIWindow, viewController: UIViewController)
    {
        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }
}

fileprivate class OutputSpy: ViewUserViewControllerOutput
{
    fileprivate var fetchUserCalled = false

    func fetchUser(request _: ViewUser.FetchUser.Request)
    {
        fetchUserCalled = true
    }
}
