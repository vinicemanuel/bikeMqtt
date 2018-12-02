//
//  ViewController.swift
//  bikeMqtt
//
//  Created by vinicius emanuel on 01/12/18.
//  Copyright © 2018 vinicius emanuel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var slider: VerticalSlider!
    @IBOutlet weak var targetLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    var viewModel: HubViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HubViewModel(wheelRadius: 0.345)
        self.collectionView.delegate = self
        self.collectionView.dataSource = viewModel as? UICollectionViewDataSource
        
        self.viewModel.delegate = self
        self.slider.maximumValue = Float(viewModel.targetKilometers)
        self.slider.minimumValue = 0.0
    }
}

extension ViewController: HubViewModelDelegate {
    func update() {
        self.slider.setValue(Float(viewModel.targetKilometers - viewModel.distanceTillMaintence()), animated: true)
        self.collectionView.reloadData()
        self.targetLabel.text = "\(viewModel.distanceTillMaintence())"
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
}
