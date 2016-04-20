//
//  ViewModel.swift
//  RxWeather
//
//  Created by Юрий Лебедев on 20.04.16.
//  Copyright © 2016 Юрий Лебедев. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
class ViewModel {
    
    private struct Constants {
        static let URLPrefix = "http://api.openweathermap.org/data/2.5/weather?q="
        static let URLPostfix = "&APPID=6247495553fd5ddfe51070a64b2aeefe"
    }
    
    let disposeBag = DisposeBag()
    
    var searchText = PublishSubject<String?>()
    var cityName = PublishSubject<String>()
    var degrees = PublishSubject<String>()

    var weather:Weather? {
        didSet {
            if let name = weather?.name {
                dispatch_async(dispatch_get_main_queue()) {
                    self.cityName.onNext(name)
                }
            }
            if let temp = weather?.degrees {
                dispatch_async(dispatch_get_main_queue()) {
                    self.degrees.onNext("\(temp)°C")
                }
            }
        }
}
    init() {
        let jsonRequest = searchText
            .map { text in
                return NSURLSession.sharedSession().rx_JSON(self.getURLForString(text!))
            }
            .switchLatest()
        
        jsonRequest
            .subscribeNext { json in
                self.weather = Weather(json: json)
            }
            .addDisposableTo(disposeBag)
}
    func getURLForString(text: String) -> NSURL{
        let url = NSURL(string: String(format: "%@%@%@",Constants.URLPrefix,text.stringByReplacingOccurrencesOfString(" ", withString: "%20"),Constants.URLPostfix))
        return url!
    }
}