//
//  MqttProviderDelegate.swift
//  bikeMqtt
//
//  Created by Matheus Coelho Berger on 02/12/18.
//  Copyright © 2018 vinicius emanuel. All rights reserved.
//

import Foundation

protocol MqttProviderDelegate {
    
    func receiveRotations(rotations: Int)
    
}
