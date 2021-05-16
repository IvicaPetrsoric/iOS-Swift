//
//  AddWeatherCityViewController.swift
//  GoodWeather
//
//  Created by ivica petrsoric on 28/10/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

protocol AddWeatherDelegate: class {
    func addWeatherDidSave(viewModel: WeatherViewModel)
}

class AddWeatherCityViewController: UIViewController {
    
    private var addCityViewModel = AddCityViewModel()
    
    @IBOutlet weak var cityNameTextField: BindingTextField! {
        didSet {
            cityNameTextField.bind { self.addCityViewModel.city = $0 }
        }
    }
    
    @IBOutlet weak var stateTextField: BindingTextField! {
        didSet {
            stateTextField.bind { self.addCityViewModel.state = $0 }
        }
    }
    
    @IBOutlet weak var zipCodeTextField: BindingTextField! {
        didSet {
            zipCodeTextField.bind { self.addCityViewModel.zipCode = $0 }
        }
    }
    
    weak var delegate: AddWeatherDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveCityButtonPressed() {
        print(self.addCityViewModel)
        
        guard let city = cityNameTextField.text else { return }
        
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=9e3329e92f9290f3e0fc059429384a12&units=Metric") {
            let weatherResource = Resource<WeatherViewModel>(url: url) { data in
                let weatherViewModel = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
                return weatherViewModel
            }
            
            Webservice().load(resource: weatherResource) { [weak self] (result) in
                if let result = result {
                    self?.delegate?.addWeatherDidSave(viewModel: result)
                    self?.close()
                }
            }
        }
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
