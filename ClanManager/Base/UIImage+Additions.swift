//
// Created by Cheese Onhead on 2/11/17.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

extension UIImageView
{
    func loadFromURL(url: URL)
    {
        URLSession.shared.dataTask(with: url)
        { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async()
            { () in
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
