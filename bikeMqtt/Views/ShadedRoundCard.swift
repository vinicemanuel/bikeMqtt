//
//  ShadedRoundCard.swift
//  bikeMqtt
//
//  Created by Matheus Coelho Berger on 02/12/18.
//  Copyright © 2018 vinicius emanuel. All rights reserved.
//

import UIKit

class ShadedRoundCard: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let layer = self.layer
        
        self.backgroundColor = UIColor.codGray
        
        layer.cornerRadius = 8
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
    }
    
    func setShadow(color: UIColor, size: Int){
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = CGFloat(size)
    }
}
