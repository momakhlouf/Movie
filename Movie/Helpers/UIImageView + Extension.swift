//
//  UIImageView + Extension.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 19/03/2023.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView{
    func loadImage(_ url : String?) {
        guard let urlStr = url else {return}
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL.init(string: urlStr))
    }
}
