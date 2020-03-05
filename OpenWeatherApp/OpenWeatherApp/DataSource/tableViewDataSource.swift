//
//  TableViewDataSource.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 05/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

final class TableViewDataSource : NSObject, UITableViewDataSource {
    
    let citiesViewModel : CitiesViewModel
    
    //MARK: - init
    init(citiesViewModel : CitiesViewModel) {
        self.citiesViewModel = citiesViewModel
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesViewModel.numberOfCities()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseId, for: indexPath) as? CityTableViewCell else {
            preconditionFailure(Texts.incorrectCell)
        }
        
        guard let city = citiesViewModel.city(at: indexPath.row) else {
            preconditionFailure(Texts.noItemInRow)
        }
        
        cell.cityNameLabel.text = city.name
        cell.cityTempLabel.text = city.showTemp
        cell.cityWeatherDescriptionLabel.text = city.shownDescription
        
        return cell
    }
    
}


