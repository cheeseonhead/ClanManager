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
  
  var sut: ViewUserInteractor!
  
  // MARK: - Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupViewUserInteractor()
  }
  
  // MARK: - Test setup
  
  func setupViewUserInteractor()
  {
    sut = ViewUserInteractor()
  }
  
  // MARK: - Test doubles
  
  // MARK: - Tests
  
  func testFetchUserTriggersPresnetUser()
  {
    // Given
    let spy = ViewUserInteractorSpy()
    sut.output = spy
    
    // When
    sut.fetchUser(request: ViewUser.FetchUser.Request())
    
    // Then
    XCTAssertTrue(spy.presentUserCalled, "Present User should be called on the output")
  }
}


class ViewUserInteractorSpy:ViewUserInteractorOutput
{
    var presentUserCalled = false
    
    func presentUser(response: ViewUser.FetchUser.Response) {
        presentUserCalled = true
    }
}
