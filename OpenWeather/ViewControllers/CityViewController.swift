//
//  CityViewController.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/10/21.
//

import UIKit

class CityViewController: UIViewController {

    //MARK: - Variables
    var location: Location!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = location.name
    }
}
