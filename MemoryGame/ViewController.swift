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
    @IBOutlet weak var startButton: EmojiButton!
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
                    
                    if (abutton.titleLabel!.text == self.startButton.titleLabel!.text)  {
                        self.animateButtonGreen(button: abutton)
                        //abutton.insideColor = .green
                    }
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
    func animateButtonGreen(button: EmojiButton) {
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseOut,
                       animations: { () -> Void in
                        
                        
                        button.insideColor = .green
        }, completion: { (finished) -> Void in
            
            
        })
        
    }
    @IBAction func pressedStartButton(_ sender: Any) {
        switch gameBoard!.currentState {
        case .start:
            showAllButtons()
        default:
            print()
        }
    }
    func showAllButtons() {
        gameBoard?.currentState = .memorize
        for abutton in allButtons {
            
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options: UIViewAnimationOptions.curveEaseIn,
                           animations: { () -> Void in
                            
                            
                            abutton.layer.transform = CATransform3DConcat(abutton.layer.transform, CATransform3DMakeRotation(CGFloat(M_PI)/2,0.0,1.0,0.0))
            }, completion: { (finished) -> Void in
                // ....
                abutton.insideColor = .white
                //abutton.setTitle(self.emoji[indice!], for: .normal)
                abutton.setTitle(self.gameBoard?.element(atIndex: self.allButtons.index(of: abutton)!), for: .normal)
                UIView.animate(withDuration: 0.5,
                               delay: 0.0,
                               options: UIViewAnimationOptions.curveEaseOut,
                               animations: { () -> Void in
                                
                                
                                abutton.layer.transform = CATransform3DConcat(abutton.layer.transform, CATransform3DMakeRotation(CGFloat(M_PI)/2,0.0,1.0,0.0))
                }, completion: { (finished) -> Void in
                    UIView.animate(withDuration: 0.5,
                                   delay: 2.0,
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
                            let lastIndex = self.allButtons.index(of: abutton)! + 1
                            if (lastIndex >= self.allButtons.count) {
                                self.startButton.titleLabel?.font = UIFont(name: "Helvetica", size: 50.0)
                                self.startPickingElements()
                                    
                                
                            }
                            
                            
                        })
                    })
                })
                
            })
            
        }
    }
    func startPickingElements() {
        gameBoard?.currentState = .pickupElements
        let theDraw = gameBoard?.drawElement()
        print(theDraw)
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: { () -> Void in
                        
                        
                        self.startButton.layer.transform = CATransform3DConcat(self.startButton.layer.transform, CATransform3DMakeRotation(CGFloat(M_PI)/2,0.0,1.0,0.0))
        }, completion: { (finished) -> Void in
            // ....
            self.startButton.insideColor = .white
            //abutton.setTitle(self.emoji[indice!], for: .normal)
            self.startButton.setTitle(theDraw, for: .normal)
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options: UIViewAnimationOptions.curveEaseOut,
                           animations: { () -> Void in
                            
                            
                            self.startButton.layer.transform = CATransform3DConcat(self.startButton.layer.transform, CATransform3DMakeRotation(CGFloat(M_PI)/2,0.0,1.0,0.0))
            }, completion: { (finished) -> Void in
                // ....
            })
        })
        
    }
    

}

