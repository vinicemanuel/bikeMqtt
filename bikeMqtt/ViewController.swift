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
    
    var mqtt: CocoaMQTT?
    let host = "broker.hivemq.com"
    let topic = "bikeiot"
//    let topic = "/topico"
    let clientID = "clienteiOSApp"
    let port = 1883
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configMQTT()
    }
    
    func configMQTT(){
        
        self.mqtt = CocoaMQTT(clientID: clientID, host: host, port: UInt16(port))
        self.mqtt?.delegate = self
        self.mqtt?.connect()
    }
}

extension ViewController: CocoaMQTTDelegate{
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print(ack)
        self.mqtt?.subscribe(topic)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
        print(topic)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        print("string", message.string)
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print(mqtt.description)
    }
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        print(mqtt.description)
    }
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print("error")
        print(err.debugDescription)
        self.mqtt?.connect()
    }
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("aqui4")
    }
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("aqui5")
    }
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        print("aqui6")
    }
}

