//
//  TabControlPresenterSpec.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-23.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

@testable import ClanManager
import Quick
import Nimble

class TabControlPresenterSpec: QuickSpec
{
    override func spec()
    {
        describe("TabControlPresenter")
        {
            var presenter: TabControlPresenter!
            var outputSpy: OutputSpy!

            beforeEach
            {
                outputSpy = OutputSpy()
                presenter = TabControlPresenter()

                presenter.output = outputSpy
            }

            context("when asked to present valid response")
            {
                beforeEach
                {
                    let validResponse = TabControl.FetchSettings.Response(currentPlayerTag: "validPlayerTag")
                    presenter.presentSettings(response: validResponse)
                }

                it("should ask the output to display settings")
                {
                    expect(outputSpy.displaySettingsCalled).toEventually(beTrue())
                }

                it("should send a valid view model to output")
                {
                    var expected = TabControl.FetchSettings.ViewModel(playerTag: "validPlayerTag")
                    expect(outputSpy.gotViewModel).toEventually(equal(expected))
                }
            }
        }
    }
}

fileprivate class OutputSpy: TabControlPresenterOutput
{
    var displaySettingsCalled = false
    var gotViewModel: TabControl.FetchSettings.ViewModel!

    func displaySettings(viewModel: TabControl.FetchSettings.ViewModel)
    {
        displaySettingsCalled = true
        gotViewModel = viewModel
    }
}
