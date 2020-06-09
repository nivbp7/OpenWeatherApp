//
//  CityFutureForecastTableViewController.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 09/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit
/*
 a child VC for the forecast temps
 */

final class CityFutureForecastTableViewController: UITableViewController {
    
    let cityForecastViewModel : CityForecastViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
    }
    
    
    //MARK: - init
    init(cityForecastViewModel : CityForecastViewModel){
        self.cityForecastViewModel = cityForecastViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Texts.noStoryboardImplementation)
    }
    
    //MARK: - config
    private func configureView() {
        view.backgroundColor = .mainColor
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: ForecastTableViewCell.reuseId)
        tableView.rowHeight = UITableView.forecastRowHeight
        tableView.separatorColor = .mainColor
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func configureTableView() {
        tableView.dataSource = cityForecastViewModel
    }
    
}
