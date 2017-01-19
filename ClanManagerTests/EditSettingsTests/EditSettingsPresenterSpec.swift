//
// Created by Jeffrey Wu on 2017-01-19.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

@testable import ClanManager
import Quick
import Nimble

class EditSettingsPresenterSpec: QuickSpec
{
    override func spec()
    {
        describe("EditSettingsPresenter")
        {
            var presenter: EditSettingsPresenter!
            var outputSpy: EditSettingsPresenterOutputSpy!

            beforeEach
            {
                outputSpy = EditSettingsPresenterOutputSpy()
                presenter = EditSettingsPresenter()
                presenter.output = outputSpy
            }

            context("when present is called with empty response")
            {
                beforeEach
                {
                    presenter.presentSettings(response: EditSettings.FetchSettings.Response())
                }

                it("should trigger display settings on output")
                {
                    expect(false).to(beTrue())
                }
            }
        }
    }
}

fileprivate class EditSettingsPresenterOutputSpy: EditSettingsPresenterOutput
{
    // Checks
    var displaySettingsCalled = false

    func displaySettings(viewModel _: EditSettings.FetchSettings.ViewModel)
    {
        displaySettingsCalled = true
    }
}
