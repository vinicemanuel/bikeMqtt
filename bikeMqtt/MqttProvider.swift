//
//  MqttProvider.swift
//  bikeMqtt
//
//  Created by Matheus Coelho Berger on 01/12/18.
//  Copyright © 2018 vinicius emanuel. All rights reserved.
//

import Foundation
import CocoaMQTT

class MqttProvider: CocoaMQTTDelegate {
    
    fileprivate var mqtt: CocoaMQTT?
    
    fileprivate let host = "broker.hivemq.com"
    fileprivate let topic = "bikeiot"
    
    fileprivate let clientID = "clienteiOSApp"
    fileprivate let port = 1883
    
    var delegate: MqttProviderDelegate?
    
    init() {
        self.mqtt = CocoaMQTT(clientID: clientID, host: host, port: UInt16(port))
        self.mqtt?.delegate = self
        self.mqtt?.connect()
    }
    
    internal func parseMessage(message: String) {
        //create rotation int from message and send to delegate
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print(ack)
        self.mqtt?.subscribe(topic)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
        print(topic)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        if let message = message.string {
            self.parseMessage(message: message)
        }
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print(err.debugDescription)
        self.mqtt?.connect()
    }

    
    ///extra stuff not needed
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
    }
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
    }
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
    }
}
