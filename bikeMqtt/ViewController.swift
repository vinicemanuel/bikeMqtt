//
//  ViewController.swift
//  bikeMqtt
//
//  Created by vinicius emanuel on 01/12/18.
//  Copyright © 2018 vinicius emanuel. All rights reserved.
//

import UIKit
import CocoaMQTT

class ViewController: UIViewController {
    
    var viewModel: HubViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HubViewModel(wheelRadius: 0.345)
    }
}
