//
//  ViewController.swift
//  MemoryGame
//
//  Created by Paolo Braccini New on 18/06/18.
//  Copyright © 2018 Paolo Braccini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var emoji = ["👽","🐹","🐷"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet var allButtons: [UIButton]!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func touchedButton(_ sender: Any) {
       let abutton = sender as! UIButton
       let indice = allButtons.index(of: abutton)
        if abutton.title(for: .normal) == "" {
            abutton.backgroundColor = .white
            abutton.setTitle(emoji[indice!], for: .normal)
            
            abutton.layer.transform = CATransform3DConcat(abutton.layer.transform, CATransform3DMakeRotation(CGFloat(M_PI),1.0,0.0,0.0))
        } else {
            abutton.backgroundColor = .orange
            abutton.setTitle("", for: .normal)
            abutton.layer.transform = CATransform3DConcat(abutton.layer.transform, CATransform3DMakeRotation(CGFloat(M_PI),1.0,0.0,0.0))
        }
    }
    

}

