//
//  WeatherDataSource.swift
//  GoodWeather
//
//  Created by ivica petrsoric on 01/11/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

//class WeatherDataSource: NSObject, UITableViewDataSource {

//    let cellIdentifier: String = "Weathere Cell"
//    private var weatherListViewModel: WeatherListViewModel
//
//    init(weatherListViewModel: WeatherListViewModel) {
//        self.weatherListViewModel = weatherListViewModel
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.weatherListViewModel.weatherViewModels.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? WeatherCell else {
//            fatalError("\(self.cellIdentifier) not found")
//        }
//
//        let weatherViewModel = self.weatherListViewModel.modelAt(indexPath.row)
//        cell.cityNameLabel.text = weatherViewModel.name
//        cell.temperatureLabel.text =
//        return cell
//    }
    
//}
