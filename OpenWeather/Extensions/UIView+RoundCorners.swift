//
//  UIView+RoundCorners.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/11/21.
//

import UIKit

extension UIView {
    func roundCorners(_ radius: CGFloat = 0.0) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
