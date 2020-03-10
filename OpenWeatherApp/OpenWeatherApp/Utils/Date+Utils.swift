//
//  Date+Utils.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 09/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

enum DateFormatingType : String {
    case fullDate = "yyyy-MM-dd HH:mm:ss"
    case time = "HH:mm:ss"
}

extension Date {
    var startOfDay : Date? {
        return Calendar.current.startOfDay(for: self)
    }
    
    var dayOfTheWeekInt : Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    func isAfter(date : Date,with granularity : Calendar.Component) -> Bool {
        let result = Calendar.current.compare(self, to: date, toGranularity: granularity)
        switch result {
        case .orderedSame,.orderedAscending:
            return false
        case .orderedDescending:
            return true
        }
    }
    
    func isAfterNoon() -> Bool? {
        let today = Date()
        var comps = Calendar.current.dateComponents([.day,.month,.year], from: today)
        comps.hour = 12
        comps.minute = 00
        comps.second = 00
        if let todayAtNoon = Calendar.current.date(from: comps) {
            if self.isAfter(date: todayAtNoon, with: .minute) {
                return true
            }else{
                return false
            }
        }
        return nil
    }
    
    func toString(with formatingType : DateFormatingType) -> String {
        let formater = DateFormatter()
        formater.dateFormat = formatingType.rawValue
        let dateString = formater.string(from: self)
        return dateString
    }
}
