//
//  ViewController.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-24.
//  Copyright © 2017 Cheeseonhead. All rights reserved.
//

import Foundation

extension UIViewController
{
    func isViewVisible() -> Bool
    {
        return self.isViewLoaded && self.view.window != nil
    }
}
