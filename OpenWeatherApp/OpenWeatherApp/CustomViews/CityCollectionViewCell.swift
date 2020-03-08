//
//  CityCollectionViewCell.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 04/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit
import MyViewsCustomized

class CityCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "CityCell"
    
    let cityNameLabel = NBPLabel(textAlignment: .center, fontSize: UIFont.cityNameFont, weight: .semibold, color: .mainColor)
    let cityTempLabel = NBPLabel(textAlignment: .center, fontSize: UIFont.cityTempFont, weight: .bold, color: .mainColor)
    let cityWeatherDescriptionLabel = NBPLabel(textAlignment: .center, fontSize: UIFont.cityWeatherDescription, weight: .regular, color: .mainColor)
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Texts.noStoryboardImplementation)
    }
    
    private func configure() {
        
        backgroundColor = .clear
        contentView.backgroundColor = .systemBackground
        contentView.layer.borderColor = UIColor.mainColor.cgColor
        contentView.layer.cornerRadius = UICollectionViewCell.cellRadius
        contentView.layer.borderWidth = UICollectionViewCell.cellBorderWidth
        
        let stackView = UIStackView(arrangedSubviews: [cityNameLabel,cityTempLabel,cityWeatherDescriptionLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UICollectionViewCell.cellPadding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UICollectionViewCell.cellPadding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UICollectionViewCell.cellPadding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UICollectionViewCell.cellPadding)
        ])
    }
    
}
