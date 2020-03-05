//
//  CitiesTableViewController.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 04/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

class CitiesTableViewController: UITableViewController {
    
    private lazy var dataSource = makeTableViewDataSource()
    let citiesViewModel : CitiesViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
    }
    
    //MARK: - init
    init(citiesViewModel : CitiesViewModel){
        self.citiesViewModel = citiesViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Texts.noStoryboardImplementation)
    }
    
    //MARK: - config
    private func configureView() {
        view.backgroundColor = .mainColor
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.reuseId)
        tableView.rowHeight = UITableView.heightForRow
        tableView.separatorColor = .mainColor
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func configureTableView() {
        tableView.dataSource = dataSource
    }
    
    //MARK: - factory
    private func makeTableViewDataSource() -> TableViewDataSource {
        return TableViewDataSource(citiesViewModel: citiesViewModel)
    }
    
}
