//
//  CityTableViewCell.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 05/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit
import MyViewsCustomized

final class CityTableViewCell: UITableViewCell {
    
    static let reuseId = "CityCell"
    
    let containerView = UIView(frame: .zero)
    
    let cityNameLabel = NBPLabel(textAlignment: .left, fontSize: UIFont.cityNameFont, weight: .semibold, color: .mainColor)
    let cityTempLabel = NBPLabel(textAlignment: .right, fontSize: UIFont.cityTempFont, weight: .bold, color: .mainColor)
    let cityWeatherDescriptionLabel = NBPLabel(textAlignment: .left, fontSize: UIFont.cityWeatherDescription, weight: .regular, color: .mainColor)
    
    let lastUpdateLabel = NBPLabel(textAlignment: .center, fontSize: UIFont.cityLastUpdate, weight: .light, color: .mainColor)
    
    
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
        
        let leftStackView = UIStackView(arrangedSubviews: [cityNameLabel,cityWeatherDescriptionLabel])
        leftStackView.axis = .vertical
        leftStackView.alignment = .leading
        leftStackView.distribution = .fillEqually
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let rightStackView = UIStackView(arrangedSubviews: [cityTempLabel,lastUpdateLabel])
        rightStackView.axis = .vertical
        rightStackView.alignment = .trailing
        rightStackView.distribution = .fillProportionally
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [leftStackView, rightStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
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
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -UITableViewCell.cellPadding),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -UITableViewCell.cellPadding/2),
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UITableViewCell.cellPadding/2),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UITableViewCell.cellPadding),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UITableViewCell.cellPadding),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UITableViewCell.cellPadding/2),
        ])
    }
}
