//
//  TableViewDataSource.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 05/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

final class TableViewDataSource : NSObject, UITableViewDataSource {
    
    let cityWeatherViewModel : CityWeatherViewModel
    
    //MARK: - init
    init(cityWeatherViewModel : CityWeatherViewModel) {
        self.cityWeatherViewModel = cityWeatherViewModel
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityWeatherViewModel.numberOfCities()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseId, for: indexPath) as? CityTableViewCell else {
            preconditionFailure(Texts.incorrectCell)
        }
        
        let shownWeather = cityWeatherViewModel.shownWeather(at: indexPath.row)
        
        cell.cityNameLabel.text = shownWeather.cityName
        cell.cityTempLabel.text = shownWeather.cityTemp
        cell.cityWeatherDescriptionLabel.text = shownWeather.tempDescription
        cell.lastUpdateLabel.text = shownWeather.lastUpdate
        
        return cell
    }
    
}


