//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol ___FILEBASENAMEASIDENTIFIER___ViewControllerInput
{
    func display___VARIABLE_subject___(viewModel: ___FILEBASENAMEASIDENTIFIER___.___VARIABLE_usecase___.ViewModel)
}

protocol ___FILEBASENAMEASIDENTIFIER___ViewControllerOutput
{
    func doSomething(request: ___FILEBASENAMEASIDENTIFIER___.___VARIABLE_usecase___.Request)
}

protocol ___FILEBASENAMEASIDENTIFIER___ViewControllerRouter: Router {}

class ___FILEBASENAMEASIDENTIFIER___ViewController: ___VARIABLE_viewControllerSubclass___, ___FILEBASENAMEASIDENTIFIER___ViewControllerInput
{
    var output: ___FILEBASENAMEASIDENTIFIER___ViewControllerOutput!
    var router: ___FILEBASENAMEASIDENTIFIER___ViewControllerRouter!

    // MARK: - Object lifecycle

    override func awakeFromNib()
    {
        super.awakeFromNib()
        ___FILEBASENAMEASIDENTIFIER___Configurator.sharedInstance.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        doSomethingOnLoad()
    }

    // MARK: - Event handling

    func doSomethingOnLoad()
    {
        // NOTE: Ask the Interactor to do some work

        let request = ___FILEBASENAMEASIDENTIFIER___.___VARIABLE_usecase___.Request()
        output.doSomething(request: request)
    }

    // MARK: - Display logic

    func display___VARIABLE_subject___(viewModel: ___FILEBASENAMEASIDENTIFIER___.___VARIABLE_usecase___.ViewModel)
    {
        // NOTE: Display the result from the Presenter

        // nameTextField.text = viewModel.name
    }
}
