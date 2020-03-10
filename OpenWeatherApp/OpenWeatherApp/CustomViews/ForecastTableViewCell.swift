//
//  ForecastTableViewCell.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 09/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit
import MyViewsCustomized

class ForecastTableViewCell: UITableViewCell {
    
    static let reuseId = "ForecastCell"
    
    let dayLabel = NBPLabel(textAlignment: .left, fontSize: UIFont.forecastDayFont, weight: .semibold, color: .mainColor)
    let tempLabel = NBPLabel(textAlignment: .right, fontSize: UIFont.forecstTempFont, weight: .bold, color: .mainColor)
    
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
        
        let stackView = UIStackView(arrangedSubviews: [dayLabel,tempLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UILabel.edgePadding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UILabel.edgePadding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UILabel.edgePadding),
            stackView.widthAnchor.constraint(equalToConstant: contentView.frame.width)
            
        ])
    }
}
