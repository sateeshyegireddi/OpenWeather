//
//  UINavigationController+TopBar.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/10/21.
//

import UIKit

extension UINavigationController {
    func defaultSettings(with title: String) {
        view.backgroundColor = .white
        navigationBar.prefersLargeTitles = true
        navigationBar.topItem?.title = title
    }
}
