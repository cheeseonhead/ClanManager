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

class ViewUserViewControllerTests: XCTestCase
{
    // MARK: - Subject under test

    var viewController: ViewUserViewController!
    var window: UIWindow!

    // MARK: - Test lifecycle

    override func setUp()
    {
        super.setUp()
        window = UIWindow()
        setupViewUserViewController()
    }

    override func tearDown()
    {
        window = nil
        super.tearDown()
    }

    // MARK: - Test setup

    func setupViewUserViewController()
    {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        viewController = storyboard.instantiateViewController(withIdentifier: "ViewUserViewController") as! ViewUserViewController
    }

    func loadView()
    {
        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: - Tests

    func testFetchUserCalledOnViewLoad()
    {
        // Given
        let viewUserControllerSpy = ViewUserViewControllerSpy()
        viewController.output = viewUserControllerSpy

        // When
        loadView()

        // Then
        XCTAssertTrue(viewUserControllerSpy.fetchUserCalled, "Fetch user should be called on view load")
    }

    func testDisplayUserCorrectly()
    {
        // Given
        let viewModel = ViewUser.FetchUser.ViewModel(name: "John Cena", info: "This player is very good")

        // When
        loadView()
        viewController.displayUser(viewModel: viewModel)

        // Then
        XCTAssertEqual(viewController.nameLabel.text, viewModel.name)
        XCTAssertEqual(viewController.infoLabel.text, viewModel.info)
    }
}

fileprivate class ViewUserViewControllerSpy: ViewUserViewControllerOutput
{
    fileprivate var fetchUserCalled = false

    func fetchUser(id: String, request _: ViewUser.FetchUser.Request)
    {
        fetchUserCalled = true
    }
}
