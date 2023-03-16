//
//  UIView + Extension.swift
//  Movie
//
//  Created by Mohamed Makhlouf Ahmed on 07/03/2023.
//

import Foundation
import UIKit

extension UIView{
    
    func round(_ radius : CGFloat = 10){
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func addBorder(color : UIColor , width : CGFloat){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
}
