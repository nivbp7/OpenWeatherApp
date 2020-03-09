//
//  CityForecastViewModel.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 08/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit


class CityForecastViewModel : NSObject {
    
    private var cityForcastArray = [CityForecast]()
    
    
    
}

//This is for fetching the Forecast data
extension CityForecastViewModel {
    
    
}

extension CityForecastViewModel : UITableViewDataSource {
    //MARK: - table view data dource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 //cityForcastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.reuseId) as? ForecastTableViewCell else {
            preconditionFailure(Texts.incorrectCell)
        }
        
        cell.dayLabel.text = "today"
        cell.tempLabel.text = "25"
        
        return cell
    }
}
