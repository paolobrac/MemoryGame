//
//  GameBoard.swift
//  MemoryGame
//
//  Created by Paolo Braccini New on 22/06/18.
//  Copyright © 2018 Paolo Braccini. All rights reserved.
//

import Foundation
class GameBoard {
    var emoji = ["👽","🐹","🐷","🐰","🐼", "🐙", "🐒","🦉","🐝","🐴","🐿","🐱","🎃","🦁","🍓","🥕","🍷","🎈"]
    var simbolToPlay = [String]()
    var simbolToDraw = [String]()
    init?(dimension: Int) {
        if dimension > emoji.count {
            return nil
        }
        for aIndex in 0..<dimension {
           
            let choice = arc4random_uniform(UInt32(emoji.count))
            let elementChosen = emoji.remove(at: Int(choice))
            simbolToPlay.append(elementChosen)
            
        }
    }
    func element(atIndex: Int)  -> String {
        return simbolToPlay[atIndex]
    }
    func casualElement() -> String {
        let choice = arc4random_uniform(UInt32(simbolToPlay.count))
        let elementChosen = simbolToPlay[Int(choice)]
        return elementChosen
        
    }
    func drawElement() -> String? {
        if simbolToDraw.count > 0 {
            let choice = arc4random_uniform(UInt32(simbolToDraw.count))
            let elementChosen = simbolToDraw.remove(at: Int(choice))
            return elementChosen
        } else {
            return nil
        }
        
    }
    
}
