//
//  HubViewModel.swift
//  bikeMqtt
//
//  Created by Matheus Coelho Berger on 02/12/18.
//  Copyright © 2018 vinicius emanuel. All rights reserved.
//

import Foundation

class HubViewModel: HubViewModelProtocol {
    
    fileprivate var mqttProvider: MqttProvider
    
    fileprivate var currentRPM: Int
    fileprivate var wheelSize: Double
    
    fileprivate var targetKilometers: Int
    
    var totalRotations: Int
    var totalDistance: Double {
        get {
            return wheelSize * Double(totalRotations)
        }
    }
    
    init(wheelRadius: Double) {
        mqttProvider = MqttProvider()
        
        currentRPM = 0
        wheelSize = wheelRadius * 2 * Double.pi
        
        targetKilometers = 50
        
        totalRotations = 0
        
        mqttProvider.delegate = self
    }
    
    func speed() -> Int {
        return Int(Double(currentRPM) * 0.10472 * wheelSize)
    }
    
    func distanceTillMaintence() -> Int {
        return Int(totalDistance)%targetKilometers
    }
}

extension HubViewModel: MqttProviderDelegate {
    
    func receiveRotations(rotations: Int) {
        print(rotations)
        
        totalRotations += rotations
        currentRPM = rotations * 30
    }
    
}
