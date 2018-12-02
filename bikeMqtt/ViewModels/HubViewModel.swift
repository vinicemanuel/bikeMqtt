//
//  HubViewModel.swift
//  bikeMqtt
//
//  Created by Matheus Coelho Berger on 02/12/18.
//  Copyright © 2018 vinicius emanuel. All rights reserved.
//

import UIKit

class HubViewModel: NSObject, HubViewModelProtocol {
    
    fileprivate var mqttProvider: MqttProvider
    
    fileprivate var instantRPS: Double
    fileprivate var wheelSize: Double
    
    var delegate: HubViewModelDelegate?
    
    var targetKilometers: Int
    
    var totalRotations: Int
    var totalDistance: Double {
        get {
            return  round(10*(wheelSize * Double(totalRotations)))/10
        }
    }
    
    init(wheelRadius: Double) {
        mqttProvider = MqttProvider()
        
        instantRPS = 0
        wheelSize = wheelRadius * 2 * Double.pi
        
        targetKilometers = 200
        
        totalRotations = 0
        
        super.init()
        mqttProvider.delegate = self
    }
    
    func speed() -> Double {
        return round(100*(Double(instantRPS) * wheelSize)*3.6)/100
    }
    
    func distanceTillMaintence() -> Int {
        return targetKilometers - Int(totalDistance)%targetKilometers
    }
}

extension HubViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "card", for: indexPath) as! CardCVCell
        
        switch indexPath.row {
        case 0:
            cell.descriptionLabel.text = "total de giros da roda"
            cell.numberLabel.text = "\(totalRotations)"
            break
        case 1:
            cell.descriptionLabel.text = "distância total andada"
            cell.numberLabel.text = "\(totalDistance)"
            break
        case 2:
            cell.descriptionLabel.text = "velocidade atual"
            cell.numberLabel.text = "\(speed())"
            break
        default:
            print("deu ruim")
        }
        
        return cell
    }
}

extension HubViewModel: MqttProviderDelegate {
    
    func receiveRotations(rotations: Int) {
        
        totalRotations += rotations
        instantRPS = Double(rotations)/2.0
        
        print("rotacões recebidas: \(rotations)")
        print("total de rotações: \(totalRotations)")
        print("distância total: \(totalDistance)")
        print("velocidade: \(speed())")
        delegate?.update()
    }
    
}
