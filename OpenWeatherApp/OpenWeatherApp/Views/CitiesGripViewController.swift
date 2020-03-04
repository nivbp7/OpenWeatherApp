//
//  CitiesGripViewController.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 04/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

class CitiesGridViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.reuseId, for: indexPath) as? CityCollectionViewCell else {
            preconditionFailure("err")
        }
        
        cell.cityNameLabel.text = "niv"
        
        return cell
    }
    

    private lazy var collectionView = makeCollectionView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()

        // Do any additional setup after loading the view.
    }
    
    private func makeCollectionView() -> UICollectionView {
           let colllectionView =  UICollectionView(frame: view.bounds, collectionViewLayout:UIConfig.createFlowLayout(in: view, numberOfColums: UICollectionView.numberOfCollectionViewColums))
        
           return colllectionView
       }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CityCollectionViewCell.self, forCellWithReuseIdentifier: CityCollectionViewCell.reuseId)
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
