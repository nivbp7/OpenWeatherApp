//
//  CollectionViewDataSource.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 05/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

class CollectionViewDataSource : NSObject, UICollectionViewDataSource {
    
    let citiesViewModel : CitiesViewModel
    
    //MARK: - init
    init(citiesViewModel : CitiesViewModel) {
        self.citiesViewModel = citiesViewModel
    }
    
    //MARK: - collection data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return citiesViewModel.numberOfCities()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.reuseId, for: indexPath) as? CityCollectionViewCell else {
            preconditionFailure(Texts.incorrectCell)
        }
        
        guard let city = citiesViewModel.city(at: indexPath.row) else {
            preconditionFailure(Texts.noItemInRow)
        }
        
        cell.cityNameLabel.text = city.name
        
        return cell
    }
    
}
