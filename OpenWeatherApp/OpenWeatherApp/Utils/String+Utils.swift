//
//  String+Utils.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 09/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation



extension String {
    func toDate(with formatingType : DateFormatingType) -> Date? {
        let formater = DateFormatter()
        formater.dateFormat = formatingType.rawValue
        let date = formater.date(from: self)
        return date
    }
}
