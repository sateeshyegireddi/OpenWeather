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
    @IBOutlet weak var helpWebView: WKWebView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //Setup
        let htmlFile = Bundle.main.path(forResource: "help",
                                        ofType: "html")
        let html = try? String(contentsOfFile: htmlFile!,
                               encoding: .utf8)
        helpWebView.loadHTMLString(html!, baseURL: nil)
    }
}
