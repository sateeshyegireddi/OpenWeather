//
//  CityViewController.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/10/21.
//

import UIKit

class CityViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var temparatureLabel: UILabel!
    @IBOutlet private weak var weatherConditionLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var feelsLikeLabel: UILabel!
    @IBOutlet private weak var maxMinTemparatureLabel: UILabel!
    @IBOutlet private weak var rainPercentageLabel: UILabel!
    @IBOutlet private weak var windDirectionLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionlabel: UILabel!
    
    //MARK: - Variables
    var location: Location!
    private var viewModel = WeatherViewModel()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup initial title
        self.title = location.name
        
        //Bind data to UI
        bindDataToUI()
        
        //Fetch weather
        fetchWeather()
    }
    
    private func bindDataToUI() {
        viewModel.isLoading.bind { [unowned self] (isLoading) in
            if isLoading { self.presentActivity() }
            else { self.dismissActivity() }
        }
        
        viewModel.error.bind { [unowned self] (error) in
            self.presentSimpleAlert(title: "Open Weather",
                                    message: error?.description ?? "")
        }
        
        viewModel.weatherFormatted.bind { (weather) in
            if let weather = weather {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.setupData(weather)
                }
            }
        }
    }
    
    private func setupData(_ weather: WeatherFormatted) {
        temparatureLabel.text = weather.temparature
        weatherConditionLabel.text = weather.condition
        weatherDescriptionlabel.text = weather.description
        weatherImageView.image = UIImage(named: "icon-\(weather.image)")
        feelsLikeLabel.text = weather.feelsLike
        maxMinTemparatureLabel.text = weather.minMaxTemparature
        rainPercentageLabel.text = weather.rainPercent
        windDirectionLabel.text = weather.windDirection
    }
    
    //MARK: - API
    private func fetchWeather() {
        viewModel.fetchWeather()
    }
    
}

extension CityViewController: ActivityPresentable {}
