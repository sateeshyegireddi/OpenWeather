//
//  HelpViewController.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/12/21.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet private weak var helpWebView: WKWebView!
    @IBOutlet private weak var resetDataButton: UIButton!
    
    //MARK: - Variables
    private var bookmarkedLocation = BookmarkedLocation()
    @LocalStorage(key: "units_type") var units: String? = nil

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //Setup
        resetDataButton.roundCorners(5.0)
        
        let htmlFile = Bundle.main.path(forResource: "help",
                                        ofType: "html")
        let html = try? String(contentsOfFile: htmlFile!,
                               encoding: .utf8)
        helpWebView.loadHTMLString(html!, baseURL: nil)
    }
    
    //MARK: - Actions
    @IBAction func resetDataButtonTapped(_ sender: Any) {
        bookmarkedLocation.removeAll()
    }
    
    @IBAction func unitsTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            units = Unit.metric.rawValue
        case 1:
            units = Unit.imperial.rawValue
        default:
            break
        }
    }
}
