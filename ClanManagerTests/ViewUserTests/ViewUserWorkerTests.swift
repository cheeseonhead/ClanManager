//
//  ViewUserWorkerTests.swift
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

class ViewUserWorkerTests: XCTestCase
{
  // MARK: - Subject under test
  
  var userWorker: UserWorker!
  
  // MARK: - Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupViewUserWorker()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupViewUserWorker()
  {
      userWorker = UserWorker(userStore: UserMemStoreSpy())
  }
  
  // MARK: - Test doubles
  
  // MARK: - Tests
  
  func testFetchUserShouldMakeRequestToStore()
  {
    // Given
    let storeSpy = userWorker.userStore as! UserMemStoreSpy
    
    // When
    userWorker.fetchUser { (_) in
    }
    
    // Then
    XCTAssertTrue(storeSpy.fetchUserCalled, "Should make a request to the store to fetch the user")
  }
    
    func testFetchUserReturnsWithAUser()
    {
        // Given
        let storeSpy = userWorker.userStore as! UserMemStoreSpy
        
        // When
        let exp = expectation(description: "Wait for fetch user to return")
        userWorker.fetchUser { (_) in
            exp.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: Double(storeSpy.asyncDelaySeconds) + 0.1) { (error) in
            XCTAssert(true, "Calling fetchUser with handler should get the completion handler called")
        }
    }
}


fileprivate class UserMemStoreSpy : UserMemStore
{
    var fetchUserCalled = false
    var asyncDelaySeconds = 1

    override func fetchUser(completionHandler: @escaping (_: User) -> Void)
    {
        fetchUserCalled = true
        let oneSecondAfter = DispatchTime.now() + DispatchTimeInterval.seconds(asyncDelaySeconds)
        DispatchQueue.main.asyncAfter(deadline: oneSecondAfter, execute: {
            completionHandler(User())
        })
    }
}
