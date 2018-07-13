//
//  TimerView.swift
//  MemoryGame
//
//  Created by Paolo Braccini New on 30/06/18.
//  Copyright © 2018 Paolo Braccini. All rights reserved.
//

import UIKit

@IBDesignable class TimerView: UIView {
    
    @IBInspectable var numberOfSeconds : Double = 5.0
    @IBInspectable var barColor : UIColor = UIColor.red
    @IBInspectable var currentSeconds: Double = 0.0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let timeRect = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: (self.bounds.size.width * CGFloat(currentSeconds)/CGFloat(numberOfSeconds)), height: self.bounds.size.height)
        let path = UIBezierPath(rect: timeRect)
        barColor.setFill()
        path.fill()
    }
    

}
