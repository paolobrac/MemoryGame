//
//  EmojiButton.swift
//  MemoryGame
//
//  Created by Paolo Braccini New on 21/06/18.
//  Copyright © 2018 Paolo Braccini. All rights reserved.
//

import UIKit

 @IBDesignable class EmojiButton: UIButton {
    @IBInspectable public  var insideColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath(ovalIn: self.bounds)
        insideColor.setFill()
        path.fill()
        let bordColor = UIColor.black
        bordColor.setStroke()
        path.stroke()
    }
    

}
