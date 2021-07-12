//
//  WeatherCell.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/12/21.
//

import UIKit

class WeatherCell: UICollectionViewCell {

    //MARK: - Variables
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var temparatureLabel: UILabel!
    @IBOutlet private weak var weatherConditionLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var feelsLikeLabel: UILabel!
    @IBOutlet private weak var maxMinTemparatureLabel: UILabel!
    @IBOutlet private weak var rainPercentageLabel: UILabel!
    @IBOutlet private weak var windDirectionLabel: UILabel!
    @IBOutlet private weak var overlayView: UIView!
    
    //MARK: - View
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        overlayView.roundCorners(10.0)
    }

    //MARK: - Setup
    func setupData(_ weather: WeatherFormatted) {
        dateLabel.text = weather.date
        temparatureLabel.text = weather.temparature
        weatherConditionLabel.text = weather.condition
        weatherImageView.image = UIImage(named: "icon-\(weather.image)")
        feelsLikeLabel.text = weather.feelsLike
        maxMinTemparatureLabel.text = weather.minMaxTemparature
        rainPercentageLabel.text = weather.rainPercent
        windDirectionLabel.text = weather.windDirection
    }
}
