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
    let containerView = UIView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configue()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(Texts.noStoryboardImplementation)
    }
    
    private func configue() {
        backgroundColor = .clear
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = UICollectionViewCell.cellRadius
        
        let stackView = UIStackView(arrangedSubviews: [cityNameLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UITableViewCell.cellPadding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UITableViewCell.cellPadding + 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UITableViewCell.cellPadding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UITableViewCell.cellPadding),
        ])
        
    }
    
}
