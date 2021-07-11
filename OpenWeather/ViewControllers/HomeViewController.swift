//
//  HomeViewController.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/10/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        //Setup
        addRightBarButton()
    }
    
    //MARK: - Bar Buttons
    private func addRightBarButton() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add,
                                      target: self,
                                      action: #selector(addButtonDidTap(_:)))
        navigationItem.rightBarButtonItem = addItem
    }
    
    @objc private func addButtonDidTap(_ sender: Any) {
        let addLocationViewController = AddLocationViewController.initWithNib()
        navigationController?.pushViewController(addLocationViewController,
                                                 animated: true)
    }
}
