//
//  CollectionViewDataSource.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 05/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

class CollectionViewDataSource : NSObject, UICollectionViewDataSource {
    
    let cityWeatherViewModel : CityWeatherViewModel
    
    //MARK: - init
    init(cityWeatherViewModel : CityWeatherViewModel) {
        self.cityWeatherViewModel = cityWeatherViewModel
    }
    
    //MARK: - collection data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityWeatherViewModel.numberOfCities()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.reuseId, for: indexPath) as? CityCollectionViewCell else {
            preconditionFailure(Texts.incorrectCell)
        }
        
        let shownWeather = cityWeatherViewModel.shownWeather(at: indexPath.row)
        
        cell.cityNameLabel.text = shownWeather.cityName
        cell.cityTempLabel.text = shownWeather.cityTemp
        cell.cityWeatherDescriptionLabel.text = shownWeather.tempDescription
        
        return cell
    }
    
}
