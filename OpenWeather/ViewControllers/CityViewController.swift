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
    @IBOutlet private weak var forecastWeatherCollectionView: UICollectionView!
    
    //MARK: - Variables
    var location: Location!
    private var viewModel = WeatherViewModel()
    private var forecastViewModel = ForecastWeatherViewModel()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup initial title
        self.title = location.name
        viewModel = WeatherViewModel(location: location)
        forecastViewModel = ForecastWeatherViewModel(location: location)
        forecastWeatherCollectionView.register(cellType: WeatherCell.self)
        
        //Bind data to UI
        bindDataToUI()
        
        //Fetch weather
        fetchWeather()
    }
    
    private func bindDataToUI() {
        //Current weather view model's binding
        viewModel.isLoading.bind { [unowned self] (isLoading) in
            if isLoading { self.presentActivity() }
            else { self.dismissActivity() }
        }
        
        viewModel.error.bind { [unowned self] (error) in
            self.presentSimpleAlert(title: "Open Weather",
                                    message: error?.description ?? "")
        }
        
        viewModel.weatherFormatted.bind { [unowned self] (weather) in
            if let weather = weather {
                DispatchQueue.main.async {
                    self.setupData(weather)
                    self.fetchForecastWeather()
                }
            }
        }
        
        //ForecastWeatherViewModel's binding
        forecastViewModel.isLoading.bind { [unowned self] (isLoading) in
            if isLoading { self.presentActivity() }
            else { self.dismissActivity() }
        }
        
        forecastViewModel.error.bind { [unowned self] (error) in
            self.presentSimpleAlert(title: "Open Weather",
                                    message: error?.description ?? "")
        }
        
        forecastViewModel.shouldReloadData.bind { [unowned self] (reload) in
            DispatchQueue.main.async {
                self.forecastWeatherCollectionView.reloadData()
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        forecastWeatherCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    //MARK: - API
    private func fetchWeather() {
        viewModel.fetchWeather()
    }
    
    private func fetchForecastWeather() {
        forecastViewModel.fetchForecastWeather()
    }
    
    //MARK: - Deinit
    deinit {
        print("\(String(describing: self)) is deallocated")
    }
}

//MARK: - UICollectionView Delegate
extension CityViewController: UICollectionViewDataSource,
                              UICollectionViewDelegate,
                              UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width,
                      height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return forecastViewModel.weathersFormatted.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: WeatherCell.self,
                                                      for: indexPath)
        cell.setupData(forecastViewModel.weathersFormatted.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

//MARK: - Spinner
extension CityViewController: ActivityPresentable {}
