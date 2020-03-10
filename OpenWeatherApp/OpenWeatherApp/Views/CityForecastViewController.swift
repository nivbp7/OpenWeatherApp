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
        
    let coreDataInterface : CoreDataInterface
    let shownCityViewModel : ShownCityViewModel

    private lazy var cityNameLabel = makeCityLabel()
    private lazy var cityTempLabel = makeCityTempLabel()
    
    var cityFuturetTableViewController : CityFutureForecastTableViewController?
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        layoutView()
        checkIfFetchRequired()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cityFuturetTableViewController?.remove()
    }
    
    //MARK: - init
    init(coreDataInterface : CoreDataInterface,shownCityViewModel : ShownCityViewModel){
        self.coreDataInterface = coreDataInterface
        self.shownCityViewModel = shownCityViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Texts.noStoryboardImplementation)
    }
    
    //MARK: - factory
    private func makeCityLabel() -> NBPLabel{
        let label = NBPLabel(textAlignment: .center, fontSize:UIFont.cityNameFont , weight: .semibold, color: .white)
        label.text = shownCityViewModel.getCityName()
        return label
    }
    
    private func makeCityTempLabel() -> NBPLabel {
        let label = NBPLabel(textAlignment: .center, fontSize: UIFont.cityTempFont, weight: .bold, color: .white)
        label.text = shownCityViewModel.getCityTemp()
        return label
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
    }
    
    //MARK: - fetch forecast data
    private func checkIfFetchRequired() {
        if coreDataInterface.checkIfUpdateRequired(for: shownCityViewModel.getCityId()) {
            fetchForecastData()
        }else{
            self.fetchCoreDataForecast(for: shownCityViewModel.getCityIdInt())
        }
    }
    
    private func fetchForecastData() {
        let dataFetch = DataFetch(coreDataInterface: coreDataInterface)
        dataFetch.fetchForecast(for: shownCityViewModel.getCityIdInt()) { [weak self] error in
            guard let self = self else {return}
            if let fetchError = error {
                print(fetchError.localizedDescription)
            }else{
                self.fetchCoreDataForecast(for: self.shownCityViewModel.getCityIdInt())
            }
        }
    }
    
    private func fetchCoreDataForecast(for cityId : Int) {
        let fetchResult = coreDataInterface.fetchForecastFor(cityId: NSNumber(value: cityId))
        switch fetchResult {
        case .success(let cityForecast):
            let cityForecastViewModel = CityForecastViewModel(cityForcast: cityForecast)
            showCityFutureTableViewController(with: cityForecastViewModel)
        case .failure(let coreDateError):
            print(coreDateError.localizedDescription)
        }
    }
    
    private func showCityFutureTableViewController(with cityForecastViewModel : CityForecastViewModel) {
        cityFuturetTableViewController = CityFutureForecastTableViewController(cityForecastViewModel: cityForecastViewModel)
        if let vc = cityFuturetTableViewController {
            self.add(vc, below: self.cityTempLabel, withPadding: UILabel.edgePadding)
        }
    }
    
    
    
    
    
}
