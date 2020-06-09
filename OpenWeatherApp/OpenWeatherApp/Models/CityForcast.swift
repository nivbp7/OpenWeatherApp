//
//  CityForcast.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 09/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation
/*
 Model for the Forecast data
 */

/*
 {
 city =     {
     coord =         {
         lat = "32.0809";
         lon = "34.7806";
     };
     country = IL;
     id = 293397;
     name = "Tel Aviv";
     sunrise = 1583726308;
     sunset = 1583768668;
     timezone = 7200;
 };
 cnt = 40;
 cod = 200;
 list =     (
             {
         clouds =             {
             all = 100;
         };
         dt = 1583744400;
         "dt_txt" = "2020-03-09 09:00:00";
         main =             {
             "feels_like" = "25.49";
             "grnd_level" = 989;
             humidity = 36;
             pressure = 1014;
             "sea_level" = 1014;
             temp = "28.94";
             "temp_kf" = "4.5";
             "temp_max" = "28.94";
             "temp_min" = "24.44";
         };
         sys =             {
             pod = d;
         };
         weather =             (
                             {
                 description = "overcast clouds";
                 icon = 04d;
                 id = 804;
                 main = Clouds;
             }
         );
         wind =             {
             deg = 123;
             speed = "5.97";
         };
     },
 
 .........
         )
 */

struct FullCityForecastForFiveDays : Codable {
    var list : [CityForecastData]
    var city : CityInfo
}

struct CityForecastData : Codable {
    
    var dtTxt : String //this is the time presentation of the forecast (e.g "2020-03-09 09:00:00")
    var main : MainInfo
}

struct MainInfo : Codable {
    var temp : Double
}

struct CityInfo : Codable {
    var id : Int
    var name : String
}

