//
//  HubViewModelProtocol.swift
//  bikeMqtt
//
//  Created by Matheus Coelho Berger on 02/12/18.
//  Copyright © 2018 vinicius emanuel. All rights reserved.
//

import Foundation

protocol HubViewModelProtocol {
    
    var totalRotations: Int { get set }
    var totalDistance: Double { get }
    
    func speed() -> Int
    
    func distanceTillMaintence() -> Int
}
