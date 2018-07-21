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
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(endGameReceived), name: Notification.Name("EndGame"), object: nil)
    }
   
    @IBOutlet var allButtons: [EmojiButton]!
    @IBOutlet weak var startButton: EmojiButton!
    @IBOutlet weak var timeLabel : TimerView!
    var startTimer : Date = Date()
    //var currentTimer : Date = Date()
    var timer = Timer()
    let levelManager = LevelManager()
    
    fileprivate let concurrentPhotoQueue =
        DispatchQueue(
            label: "com.raywenderlich.GooglyPuff.photoQueue")
        
    
    //costants
    //let numberOfSecondsToChoose = 6.0
    //let numberOfSecondsToMemorize = 10.0
    
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
                    } else {
                        self.rotateButton (button: abutton)
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
                        
                        button.alpha = 0.0
                        button.insideColor = .green
        }, completion: { (finished) -> Void in
            
            button.isUserInteractionEnabled = false
            self.startPickingElements()
        })
        
    }
    func rotateButton (button: EmojiButton) {
        
        UIView.animate(withDuration: 0.5,
                       delay: 1.0,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: { () -> Void in
                        button.layer.transform = CATransform3DConcat(button.layer.transform, CATransform3DMakeRotation(CGFloat(M_PI)/2,0.0,1.0,0.0))
                        
        }, completion: { (finished) -> Void in
            // ....
            button.insideColor = .red
            button.setTitle("", for: .normal)
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options: UIViewAnimationOptions.curveEaseOut,
                           animations: { () -> Void in
                            button.layer.transform = CATransform3DConcat(button.layer.transform, CATransform3DMakeRotation(CGFloat(M_PI)/2,0.0,1.0,0.0))
                            
            }, completion: { (finished) -> Void in
                // ....
            })
        })
        
    }
    @IBAction func pressedStartButton(_ sender: Any) {
        switch gameBoard!.currentState {
        case .start:
            showAllButtons()
        case .memorize:
            finishShowingButtons()
        default:
            print()
        }
    }
    func showAllButtons() {
        gameBoard?.currentState = .memorize
        print("Seconds")
        print(levelManager.getNumberOfSecondsToShow())
        for abutton in allButtons {
            //using transizion
            UIView.transition(with: abutton, duration: 1.5, options: [.transitionFlipFromRight], animations: {() -> Void in abutton.insideColor = .white
                //abutton.setTitle(self.emoji[indice!], for: .normal)
                abutton.setTitle(self.gameBoard?.element(atIndex: self.allButtons.index(of: abutton)!), for: .normal)}
                , completion: { (finished) -> Void in
                    //self.finishShowingButtons()
                    let lastIndex = self.allButtons.index(of: abutton)! + 1
                    if (lastIndex >= self.allButtons.count) {
                        self.timeLabel.numberOfSeconds = self.levelManager.getNumberOfSecondsToImpress()
                        self.timeLabel.currentSeconds = 0
                        self.timeLabel.barColor = .red
                        self.startTimer = Date()
                        self.runTimer()
                    }
                        
                    })
            /*
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
                    //self.finishShowingButtons()
                    let lastIndex = self.allButtons.index(of: abutton)! + 1
                    if (lastIndex >= self.allButtons.count) {
                        self.timeLabel.numberOfSeconds = self.levelManager.getNumberOfSecondsToImpress()
                        self.timeLabel.currentSeconds = 0
                        self.timeLabel.barColor = .red
                        self.startTimer = Date()
                        self.runTimer()
                        
                    }
                    
                    
 
                })
                
            }) */
            
        }
    }
    func startPickingElements() {
        self.startTimer = Date()
        gameBoard?.currentState = .pickupElements
        let theDraw = gameBoard?.drawElement()
        
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
                self.timeLabel.numberOfSeconds = self.levelManager.getNumberOfSecondsToShow()
                self.timeLabel.currentSeconds = 0
                self.timeLabel.barColor = .red
                
                //self.runTimer()
                
            })
        })
        
    }
    @objc func endGameReceived() {
        //print ("endgame")
        endGameWinning()
    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        
        concurrentPhotoQueue.async {
            
            var timePassed = self.startTimer.timeIntervalSinceNow * -1
            if self.timer.isValid {
                if self.gameBoard?.currentState == .memorize {
                    if self.levelManager.getNumberOfSecondsToImpress() < timePassed {
                        //self.timer.invalidate()
                        DispatchQueue.main.async {
                            self.finishShowingButtons()
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.timeLabel.currentSeconds = timePassed
                        }
                        
                    }
                    
                } else if self.gameBoard?.currentState == .pickupElements {
                    if self.levelManager.getNumberOfSecondsToShow() > timePassed {
                        DispatchQueue.main.async {
                            self.timeLabel.currentSeconds = timePassed
                        }
                    }  else {
                        /*
                         if gameBoard?.currentState == .memorize {
                         timer.invalidate()
                         
                         }*/
                        //self.timer.invalidate()
                        //print("endgame")
                        DispatchQueue.main.async {
                            self.endGameLosing()
                        }
                    }
                }
            }
        }
       
        
        
    }
    func finishShowingButtons() {
        for abutton in allButtons {
            UIView.transition(with: abutton, duration: 1.5, options: [.transitionFlipFromLeft], animations: {() -> Void in abutton.insideColor = .red
                abutton.setTitle("", for: .normal) }
                , completion: { (finished) -> Void in
                    //self.finishShowingButtons()
                    let lastIndex = self.allButtons.index(of: abutton)! + 1
                    if (lastIndex >= self.allButtons.count) {
                        self.startButton.titleLabel?.text = ""
                        self.startButton.titleLabel?.font = UIFont(name: "Helvetica", size: 50.0)
                        self.runTimer()
                        self.startPickingElements()
                    }
                    
            })
            /*
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
                    let lastIndex = self.allButtons.index(of: abutton)! + 1
                    if (lastIndex >= self.allButtons.count) {
                        self.startButton.titleLabel?.text = ""
                        self.startButton.titleLabel?.font = UIFont(name: "Helvetica", size: 50.0)
                        self.runTimer()
                        self.startPickingElements()
                        
                        
                    }
                    
                    
                })
            }) */
        }
    }
    func endGameLosing(){
        timer.invalidate()
        levelManager.modifySeconds(winning: false)
        let losingMessage = UIAlertController(title: "Game Over", message: "Sorry you did  not complete the task", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        losingMessage.addAction(OKAction)
        
        self.present(losingMessage, animated: true)
        
    }
    func endGameWinning(){
        timer.invalidate()
        levelManager.modifySeconds(winning: true)
        let winningMessage = UIAlertController(title: "Congratulation", message: "Level Completed", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        winningMessage.addAction(OKAction)
        
        self.present(winningMessage, animated: true)
        
    }

}

