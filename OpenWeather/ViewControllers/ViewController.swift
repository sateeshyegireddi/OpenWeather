//
//  ViewController.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/9/21.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Home Tab
        let homeViewController = HomeViewController()
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        homeNavigationController.defaultSettings(with: "Home")
        let homeBarItem = UITabBarItem(title: "Home",
                                       image: UIImage(named: "icon-home"),
                                       selectedImage: UIImage(named: "icon-home-selected"))
        homeNavigationController.tabBarItem = homeBarItem
        
        //Settings Tab
        let settingsViewController = SettingsViewController()
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        settingsNavigationController.defaultSettings(with: "Settings")
        let settingsBarItem = UITabBarItem(title: "Settings",
                                           image: UIImage(named: "icon-settings"),
                                           selectedImage: UIImage(named: "icon-settings-selected"))
        settingsNavigationController.tabBarItem = settingsBarItem
        
        //Set Viewcontrollers
        self.viewControllers = [homeNavigationController, settingsNavigationController]
    }
}

