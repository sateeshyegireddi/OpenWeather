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
        let homeViewController = HomeViewController.initWithNib()
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        homeNavigationController.defaultSettings(with: "Home")
        let homeBarItem = UITabBarItem(title: "Home",
                                       image: UIImage(named: "icon-home"),
                                       selectedImage: UIImage(named: "icon-home-selected"))
        homeNavigationController.tabBarItem = homeBarItem
        
        //Help Tab
        let helpViewController = HelpViewController.initWithNib()
        let helpNavigationController = UINavigationController(rootViewController: helpViewController)
        helpNavigationController.defaultSettings(with: "Settings")
        let helpBarItem = UITabBarItem(title: "Help",
                                           image: UIImage(named: "icon-help"),
                                           selectedImage: UIImage(named: "icon-help-selected"))
        helpNavigationController.tabBarItem = helpBarItem
        
        //Set Viewcontrollers
        self.viewControllers = [homeNavigationController, helpNavigationController]
    }
}

