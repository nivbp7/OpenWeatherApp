//
//  ForecastTableViewCell.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 09/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit
import MyViewsCustomized

final class ForecastTableViewCell: UITableViewCell {
    
    static let reuseId = "ForecastCell"
    
    let containerView = UIView(frame: .zero)

    let dayLabel = NBPLabel(textAlignment: .left, fontSize: UIFont.forecastDayFont, weight: .semibold, color: .mainColor)
    let tempLabel = NBPLabel(textAlignment: .right, fontSize: UIFont.forecstTempFont, weight: .bold, color: .mainColor)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(Texts.noStoryboardImplementation)
    }
    
    private func configure() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = UICollectionViewCell.cellRadius
        
        let stackView = UIStackView(arrangedSubviews: [dayLabel,tempLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = UICollectionViewCell.cellRadius
        
        contentView.addSubview(containerView)
        containerView.addSubview(stackView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: UITableViewCell.cellPadding/2),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: UITableViewCell.cellPadding),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -UITableViewCell.cellPadding/2),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -UITableViewCell.cellPadding),
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UITableViewCell.cellPadding/2),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UITableViewCell.cellPadding),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UITableViewCell.cellPadding/2),
            containerView.widthAnchor.constraint(equalToConstant: contentView.frame.width + 10)
           
        ])
    }
}
