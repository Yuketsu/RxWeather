//
//  Weather.swift
//  RxWeather
//
//  Created by Юрий Лебедев on 20.04.16.
//  Copyright © 2016 Юрий Лебедев. All rights reserved.
//

import Foundation
import SwiftyJSON

class Weather {
    var name:String?
    var degrees:Double?
    
    init(json: AnyObject) {
        let data = JSON(json)
        self.name = data["name"].stringValue
        self.degrees = data["main"]["temp"].doubleValue - 273.15
    }
}