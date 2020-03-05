//
//  UIViewController+Utils.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 04/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child : UIViewController,below showenView : UIView,withPadding padding : CGFloat) {
        addChild(child)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(child.view)
        
        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            child.view.topAnchor.constraint(equalTo: showenView.bottomAnchor, constant: padding),
            child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
