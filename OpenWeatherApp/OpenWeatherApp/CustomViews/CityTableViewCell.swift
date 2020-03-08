//
//  CityTableViewCell.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 05/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit
import MyViewsCustomized

class CityTableViewCell: UITableViewCell {
    
    static let reuseId = "CityCell"
    
    let cityNameLabel = NBPLabel(textAlignment: .left, fontSize: UIFont.cityNameFont, weight: .semibold, color: .mainColor)
    let cityTempLabel = NBPLabel(textAlignment: .right, fontSize: UIFont.cityTempFont, weight: .bold, color: .mainColor)
    let cityWeatherDescriptionLabel = NBPLabel(textAlignment: .left, fontSize: UIFont.cityWeatherDescription, weight: .regular, color: .mainColor)
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configue()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(Texts.noStoryboardImplementation)
    }
    
    private func configue() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = UICollectionViewCell.cellRadius
        
        let leftStackView = UIStackView(arrangedSubviews: [cityNameLabel,cityWeatherDescriptionLabel])
        leftStackView.axis = .vertical
        leftStackView.alignment = .leading
        leftStackView.distribution = .fillEqually
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let stackView = UIStackView(arrangedSubviews: [leftStackView, cityTempLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UITableViewCell.cellPadding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UITableViewCell.cellPadding + 20),
            stackView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UITableViewCell.cellPadding),
        ])
        
    }
    
}
