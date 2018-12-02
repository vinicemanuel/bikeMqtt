//
//  VerticalSlider.swift
//  bikeMqtt
//
//  Created by Matheus Coelho Berger on 02/12/18.
//  Copyright © 2018 vinicius emanuel. All rights reserved.
//

import UIKit

class VerticalSlider: UISlider {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func setup() {
        self.minimumTrackTintColor = UIColor.brightSun
        self.setThumbImage(UIImage(), for: .normal)
        
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
        
        self.transform = self.transform.rotated(by: CGFloat.pi/2)
    }
    
    @IBInspectable open var trackWidth:CGFloat = 2 {
        didSet {setNeedsDisplay()}
    }
    
    override open func trackRect(forBounds bounds: CGRect) -> CGRect {
        let defaultBounds = super.trackRect(forBounds: bounds)
        return CGRect(
            x: defaultBounds.origin.x,
            y: defaultBounds.origin.y + defaultBounds.size.height/2 - trackWidth/2,
            width: defaultBounds.size.width,
            height: trackWidth
        )
    }
}
