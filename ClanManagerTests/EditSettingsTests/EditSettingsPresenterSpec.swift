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
                    expect(outputSpy.displaySettingsCalled).toEventually(beTrue())
                }
            }

            context("when present is called with filled response")
            {
                var fakeResponse: EditSettings.FetchSettings.Response!
                var expectedViewModel: EditSettings.FetchSettings.ViewModel!
                beforeEach
                {
                    fakeResponse = EditSettings.FetchSettings.Response(currentPlayerTag: "thisIsFake")
                    expectedViewModel = EditSettings.FetchSettings.ViewModel(currentPlayerTag: "thisIsFake")
                    presenter.presentSettings(response: fakeResponse)
                }

                it("should trigger display settings on output with valid view model")
                {
                    expect(outputSpy.resultViewModel).toEventually(equal(expectedViewModel))
                }
            }
        }
    }
}

fileprivate class EditSettingsPresenterOutputSpy: EditSettingsPresenterOutput
{
    // Checks
    var displaySettingsCalled = false
    var resultViewModel: EditSettings.FetchSettings.ViewModel!
    var displayStoreSettingsCalled = false
    var storeViewModelGiven: EditSettings.StoreSettings.ViewModel!

    func displaySettings(viewModel: EditSettings.FetchSettings.ViewModel)
    {
        displaySettingsCalled = true
        resultViewModel = viewModel
    }

    func displayStoreSettings(viewModel: EditSettings.StoreSettings.ViewModel)
    {
        displayStoreSettingsCalled = true
        storeViewModelGiven = viewModel
    }
}
