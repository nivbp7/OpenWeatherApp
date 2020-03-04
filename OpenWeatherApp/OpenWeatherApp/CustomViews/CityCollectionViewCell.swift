//
//  CityCollectionViewCell.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 04/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "CityCell"
    
    let cityNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Texts.noStoryboardImplementation)
    }
    
    private func configure() {
        backgroundColor = .red
        addSubview(cityNameLabel)
    }
    
}
