//
//  ViewController.swift
//  MemoryGame
//
//  Created by Paolo Braccini New on 18/06/18.
//  Copyright © 2018 Paolo Braccini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //var emoji = ["👽","🐹","🐷","🐰","🐼", "🐙", "🐒","🦉","🐝","🐴","🐿","🐱","🎃","🦁","🍓","🥕","🍷","🎈"]
    var gameBoard = GameBoard(dimension: 16)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet var allButtons: [EmojiButton]!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func touchedButton(_ sender: Any) {
       let abutton = sender as! EmojiButton
       let indice = allButtons.index(of: abutton)
        if abutton.title(for: .normal) == "" {
            
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options: UIViewAnimationOptions.curveEaseIn,
                           animations: { () -> Void in
                            
                            
                            abutton.layer.transform = CATransform3DConcat(abutton.layer.transform, CATransform3DMakeRotation(CGFloat(M_PI)/2,0.0,1.0,0.0))
            }, completion: { (finished) -> Void in
                // ....
                abutton.insideColor = .white
                //abutton.setTitle(self.emoji[indice!], for: .normal)
                abutton.setTitle(self.gameBoard?.element(atIndex: indice!), for: .normal)
                UIView.animate(withDuration: 0.5,
                               delay: 0.0,
                               options: UIViewAnimationOptions.curveEaseOut,
                               animations: { () -> Void in
                                
                                
                                abutton.layer.transform = CATransform3DConcat(abutton.layer.transform, CATransform3DMakeRotation(CGFloat(M_PI)/2,0.0,1.0,0.0))
                }, completion: { (finished) -> Void in
                    // ....
                })
            })
            
            //abutton.layer.transform = CATransform3DConcat(abutton.layer.transform, CATransform3DMakeRotation(CGFloat(M_PI)/8,0.0,1.0,0.0))
            
            
        } else {
            
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options: UIViewAnimationOptions.curveEaseIn,
                           animations: { () -> Void in
                            abutton.layer.transform = CATransform3DConcat(abutton.layer.transform, CATransform3DMakeRotation(CGFloat(M_PI)/2,0.0,1.0,0.0))
                            
            }, completion: { (finished) -> Void in
                // ....
                abutton.insideColor = .red
                abutton.setTitle("", for: .normal)
                UIView.animate(withDuration: 0.5,
                               delay: 0.0,
                               options: UIViewAnimationOptions.curveEaseOut,
                               animations: { () -> Void in
                                abutton.layer.transform = CATransform3DConcat(abutton.layer.transform, CATransform3DMakeRotation(CGFloat(M_PI)/2,0.0,1.0,0.0))
                                
                }, completion: { (finished) -> Void in
                    // ....
                })
            })
            
            
            
            //abutton.layer.transform = CATransform3DConcat(abutton.layer.transform, CATransform3DMakeRotation(CGFloat(M_PI)/8,0.0,1.0,0.0))
           
        }
    }
    

}

