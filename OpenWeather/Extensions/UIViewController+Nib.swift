//
//  UIViewController+Nib.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/11/21.
//

import UIKit

extension UIViewController {
    static func initWithNib() -> Self {
        let viewController = Self.init(nibName: String(describing: self),
                                       bundle: nil)
        return viewController
    }
}
