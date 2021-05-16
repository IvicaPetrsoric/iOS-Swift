//
//  WeatherDetailsViewController.swift
//  GoodWeather
//
//  Created by ivica petrsoric on 30/10/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    var weatherViewModel: WeatherViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.cityNameLabel.text = self.weatherViewModel?.name.value
//        self.currentTemperatureLabel.text = self.weatherViewModel?.currentTemperature.temperature.value.formatAsDegree
        
        setupViewModelBindings()
    }
    
    private func setupViewModelBindings() {
        if let weatherViewModel = weatherViewModel {
            weatherViewModel.name.bind { self.cityNameLabel.text = $0 }
            weatherViewModel.currentTemperature.temperature.bind { self.currentTemperatureLabel.text = $0.formatAsDegree }
            weatherViewModel.currentTemperature.temperatureMax.bind { self.maxTempLabel.text = $0.formatAsDegree }
            weatherViewModel.currentTemperature.temperatureMin.bind { self.minTempLabel.text = $0.formatAsDegree }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.weatherViewModel?.name.value = "Boston"
            }
        }
    }
    
}
