//
//  CitiesListViewController.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 03/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit
import MyViewsCustomized

final class CitiesListViewController: UIViewController {
    
    private lazy var stateButton = makeStateButton()
    private lazy var citiesTableViewController = makeCitiesTableViewController()
    private lazy var citiesCollectionViewController = makeCitiesCollectionViewController()
    
    private var citiesShownInGrid = UserDefaults.standard.citiesShownInGrid
    
    let citiesViewModel : CitiesViewModel
    let coreDataInterface : CoreDataInterface
    let cityWeatherViewModel : CityWeatherViewModel
    
    //MARK: - init
    init(citiesViewModel : CitiesViewModel,cityWeatherViewModel : CityWeatherViewModel,coreDataInterface : CoreDataInterface){
        self.citiesViewModel = citiesViewModel
        self.cityWeatherViewModel = cityWeatherViewModel
        self.coreDataInterface = coreDataInterface
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Texts.noStoryboardImplementation)
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureChildViewControllers()
        layoutView()
        fetchCurrentWeather()
    }
    
    
    //MARK: - factory
    private func makeCitiesCollectionViewController() -> CitiesGridViewController {
        return CitiesGridViewController(cityWeatherViewModel: cityWeatherViewModel)
    }
    
    private func makeCitiesTableViewController() -> CitiesTableViewController {
        return CitiesTableViewController(cityWeatherViewModel: cityWeatherViewModel)
    }
    
    private func makeStateButton() -> NBPButton {
        let buttonTitle = citiesShownInGrid ? Texts.switchToList : Texts.switchToGrid
        let stateButton = NBPButton(backgroundColor: .buttonBackgroundColor, title: buttonTitle,borderColor: .black)
        stateButton.addTarget(self, action: #selector(stateButtonTapped), for: .touchUpInside)
        return stateButton
    }

    
    //MARK: - configure
    private func configureView() {
        title = Texts.citiesTitle
        view.backgroundColor = .mainColor
        view.addSubview(stateButton)
        if citiesShownInGrid {
            showGridView()
        }else{
            showListView()
        }
    }
    
    private func configureChildViewControllers() {
        citiesTableViewController.onIndexPathSelected = { [weak self] indexPath in
            self?.showCityForecast(for: indexPath)
        }
        
        citiesCollectionViewController.onIndexPathSelected = { [weak self] inndexPAth in
            self?.showCityForecast(for: inndexPAth)
        }        
    }
    
    //MARK: - layout
    private func layoutView() {
        NSLayoutConstraint.activate([
            stateButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIButton.edgePadding),
            stateButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: UIButton.fullWidthPadding),
            stateButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -UIButton.fullWidthPadding),
            stateButton.heightAnchor.constraint(equalToConstant: UIButton.height)
        ])
    }
    
    
    // MARK: - actions
    @objc private func stateButtonTapped() {
        toggleViewState()
    }
    
    private func toggleViewState() {
        var citiesShownInGrid = UserDefaults.standard.citiesShownInGrid
        if citiesShownInGrid {
            //we are now in a grid view, so switch to list
            showListView()
        }else{
            showGridView()
        }
        
        citiesShownInGrid.toggle()
        UserDefaults.standard.citiesShownInGrid = citiesShownInGrid
    }
    
    //MARK: - changing views
    private func showListView() {
        add(citiesTableViewController, below: stateButton, withPadding: UIButton.edgePadding)
        citiesCollectionViewController.remove()
        stateButton.setTitle(Texts.switchToGrid, for: .normal)//we set the text to read "switch to grid", because we are now showing a list
    }
    
    private func showGridView() {
        add(citiesCollectionViewController, below: stateButton, withPadding: UIButton.edgePadding)
        citiesTableViewController.remove()
        stateButton.setTitle(Texts.switchToList, for: .normal)
    }
    
    //MARK: - fetch data
    private func fetchCurrentWeather() {
        let dataFetch = DataFetch(coreDataInterface: coreDataInterface)
        dataFetch.fetchAllWeatherFrom(citiesViewModel: citiesViewModel) { [weak self] in
            guard let self = self else {return}
            let allWeather = self.coreDataInterface.fetchAllCities()
            
            switch allWeather {
            case .success(let cityWeatherArray):
                self.cityWeatherViewModel.updateAllCityWeather(cityWeatherArray: cityWeatherArray)
                if self.citiesShownInGrid {
                    self.citiesCollectionViewController.reload()
                }else{
                    self.citiesTableViewController.reload()
                }
            case .failure(_):
                break
            }
        }
    }
    
    //MARK: - show detailed city forecast
    private func showCityForecast(for indexPath : IndexPath) {
        let cityWeather = cityWeatherViewModel.shownWeather(at: indexPath.row)
        let showCityViewModel = ShownCityViewModel(cityName: cityWeather.cityName, cityTemp: cityWeather.cityTemp, cityId: cityWeather.cityId)
        let cityForecastViewController = CityForecastViewController(coreDataInterface: coreDataInterface, shownCityViewModel: showCityViewModel)
        navigationController?.pushViewController(cityForecastViewController, animated: true)
    }
    
    
    
    
    
    
}
