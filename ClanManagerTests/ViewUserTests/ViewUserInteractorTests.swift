//
//  ViewUserInteractorTests.swift
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

class ViewUserInteractorTests: XCTestCase
{
  // MARK: - Subject under test

  var interactor: ViewUserInteractor!

  // MARK: - Test lifecycle

  override func setUp()
  {
    super.setUp()
    setupViewUserInteractor()
  }

  // MARK: - Test setup

  func setupViewUserInteractor()
  {
    interactor = ViewUserInteractor()
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testFetchUserTriggersPresentUser()
  {
    // Given
    let outputSpy = ViewUserInteractorSpy()
    interactor.output = outputSpy
    let workerSpy = UserWorkerSpy(userStore: UserMemStore())
    interactor.worker = workerSpy

    // When
    interactor.fetchUser(request: ViewUser.FetchUser.Request())

    // Then
      XCTAssertTrue(workerSpy.fetchUserCalled, "Should call the worker to fetch the user.")
    XCTAssertTrue(outputSpy.presentUserCalled, "Present User should be called on the output.")
  }
}


fileprivate class ViewUserInteractorSpy:ViewUserInteractorOutput
{
    var presentUserCalled = false

    func presentUser(response: ViewUser.FetchUser.Response)
    {
        presentUserCalled = true
    }
}


fileprivate class UserWorkerSpy:UserWorker
{
    var fetchUserCalled = false

    override func fetchUser(completionHandler:(_:User)->Void)
    {
        fetchUserCalled = true
        completionHandler(User())
    }
}
