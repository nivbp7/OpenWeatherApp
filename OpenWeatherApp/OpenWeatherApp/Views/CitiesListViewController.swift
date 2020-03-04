//
//  CitiesListViewController.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 03/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit
import MyViewsCustomized

class CitiesListViewController: UIViewController {
    
    private lazy var stateButton = makeStateButton()
    private lazy var citiesTableViewController = makeCitiesTableViewController()
    private lazy var citiesCollectionViewController = makeCitiesCollectionViewController()
    
    private var citiesShownInGrid = UserDefaults.standard.citiesShownInGrid
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        layoutView()
    }
    
    
    //MARK: - factory
    
    private func makeCitiesCollectionViewController() -> CitiesGridViewController {
        return CitiesGridViewController()
    }
    
    private func makeCitiesTableViewController() -> CitiesTableViewController {
        return CitiesTableViewController()
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
    
    private func showListView() {
        add(citiesTableViewController, adjacentTo: stateButton)
        citiesCollectionViewController.remove()
        stateButton.setTitle(Texts.switchToGrid, for: .normal)//we set the text to read "switch to grid", because we are now showing a list
    }
    
    private func showGridView() {
        add(citiesCollectionViewController, adjacentTo: stateButton)
        citiesTableViewController.remove()
        stateButton.setTitle(Texts.switchToList, for: .normal)
    }
    
    
}
