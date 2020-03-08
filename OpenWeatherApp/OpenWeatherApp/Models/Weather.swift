//
//  Weather.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 07/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation
/*
{
    base = stations;
    clouds =     {
        all = 40;
    };
    cod = 200;
    coord =     {
        lat = "32.08";
        lon = "34.78";
    };
    dt = 1583566386;
    id = 293397;
    main =     {
        "feels_like" = "15.26";
        humidity = 77;
        pressure = 1019;
        temp = "16.09";
        "temp_max" = "17.78";
        "temp_min" = "14.44";
    };
    name = "Tel Aviv";
    sys =     {
        country = IL;
        id = 6845;
        sunrise = 1583553658;
        sunset = 1583595781;
        type = 1;
    };
    timezone = 7200;
    visibility = 10000;
    weather =     (
                {
            description = "scattered clouds";
            icon = 03d;
            id = 802;
            main = Clouds;
        }
    );
    wind =     {
        deg = 180;
        speed = "2.1";
    };
}
 */

struct CurrentWeather :Codable {
    
    struct Main : Codable {
        var temp : Double
    }
        
    struct WeatherData : Codable {
        var description : String
    }
    
    var name : String
    var main : Main
    var id : Int
    var dt : TimeInterval
    var weather : [WeatherData]
}

