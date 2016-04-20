//
//  ViewController.swift
//  RxWeather
//
//  Created by Юрий Лебедев on 20.04.16.
//  Copyright © 2016 Юрий Лебедев. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Binding the UI
        viewModel.cityName.bindTo(cityNameLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        viewModel.degrees.bindTo(degreesLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        nameTextField.rx_text.subscribeNext { text in
            self.viewModel.searchText.onNext(text)
            }
            .addDisposableTo(disposeBag)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

