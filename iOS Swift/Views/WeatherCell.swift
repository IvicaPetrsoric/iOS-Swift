//
//  WeatherCell.swift
//  GoodWeather
//
//  Created by ivica petrsoric on 28/10/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func configure(_ viewModel: WeatherViewModel) {
        self.cityNameLabel?.text = viewModel.name.value
        self.temperatureLabel?.text = "\(viewModel.currentTemperature.temperature.value.formatAsDegree)"
    }
    
}
