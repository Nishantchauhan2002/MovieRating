//
//  UIViewExtension.swift
//  MovieTrending
//
//  Created by Nishant Chauhan on 01/02/24.
//

import Foundation
import UIKit

extension UIView{
    func round(_ radius:CGFloat = 10){
        self.layer.cornerRadius=radius
        self.clipsToBounds=true
    }
    func addBorder(color:UIColor,width:CGFloat){
        
        self.layer.borderColor=color.cgColor
        self.layer.borderWidth=width
    }
}
