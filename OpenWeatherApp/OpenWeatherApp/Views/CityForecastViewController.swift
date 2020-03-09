//
//  CityForecastViewController.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 08/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit
import MyViewsCustomized

class CityForecastViewController: UIViewController {
    
    let cityForecastViewModel : CityForecastViewModel
    
    private lazy var cityNameLabel = makeCityLabel()
    private lazy var cityTempLabel = makeCityTempLabel()
    private lazy var cityFuturetTableViewController = makeCityFuturetTableViewController()
    
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        layoutView()
        
        let dataFetch = DataFetch(coreDataInterface: nil)
        dataFetch.fetchForecast(for: 293397) {
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cityFuturetTableViewController.remove()
    }
    
    //MARK: - init
    init(cityForecastViewModel : CityForecastViewModel){
        self.cityForecastViewModel = cityForecastViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Texts.noStoryboardImplementation)
    }
    
    //MARK: - factory
    private func makeCityLabel() -> NBPLabel{
        let label = NBPLabel(textAlignment: .center, fontSize:UIFont.cityNameFont , weight: .semibold, color: .white)
        label.text = "city"
        return label
    }
    
    private func makeCityTempLabel() -> NBPLabel {
        let label = NBPLabel(textAlignment: .center, fontSize: UIFont.cityTempFont, weight: .bold, color: .white)
        label.text = "25"
        return label
    }
    
    private func makeCityFuturetTableViewController() -> CityFutureForecastTableViewController {
        return CityFutureForecastTableViewController()
//        return CitiesTableViewController(cityWeatherViewModel: cityWeatherViewModel)
    }
    
    //MARK: - configure
    
    private func configureView() {
        view.backgroundColor = .mainColor
    }
    
    
    //MARK: -layout
    private func layoutView() {
        view.addSubview(cityNameLabel)
        view.addSubview(cityTempLabel)
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UILabel.edgePadding),
            cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityNameLabel.heightAnchor.constraint(equalToConstant: UILabel.height),
            
            cityTempLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: UILabel.edgePadding),
            cityTempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityTempLabel.heightAnchor.constraint(equalToConstant: UILabel.height),
            
        ])
        
        add(cityFuturetTableViewController, below: cityTempLabel, withPadding: UILabel.edgePadding)
    }
    
    
    
    
    
    
}
