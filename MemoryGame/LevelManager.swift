//
//  LevelManager.swift
//  MemoryGame
//
//  Created by Paolo Braccini New on 08/07/18.
//  Copyright © 2018 Paolo Braccini. All rights reserved.
//

import Foundation
class LevelManager {
    func getNumberOfSecondsToImpress() -> Double {
        
        let defaults = UserDefaults.standard
        if  defaults.double(forKey: "seconds") > 0  {
        
            return defaults.double(forKey: "seconds") * multiplyFactor
            
        } else {
            defaults.set(defaultWaitingTime, forKey:"seconds")
            defaults.synchronize()
            return defaultWaitingTime * multiplyFactor
            
        }
        
        
    }
    func getNumberOfSecondsToShow() -> Double {
        
        let defaults = UserDefaults.standard
        if  defaults.double(forKey: "seconds") > 0  {
            
            return defaults.double(forKey: "seconds")
            
        } else {
            defaults.set(defaultWaitingTime, forKey:"seconds")
            defaults.synchronize()
            return defaultWaitingTime
            
        }
        
    }
    func modifySeconds(winning: Bool) {
        var factor = 1.0
        let defaults = UserDefaults.standard
        var newseconds = defaults.double(forKey: "seconds")
        if winning {
            factor = factor - increaseDecreasePercentage
            newseconds = newseconds * factor
            if newseconds > 0 {
                defaults.set(newseconds, forKey: "seconds")
                /*
                if newseconds > defaults.double(forKey: "maxSeconds") {
                    defaults.set(newseconds, forKey: "maxSeconds")
                } */
                defaults.synchronize()
 
            }
            
        } else {
            factor = factor + increaseDecreasePercentage
            newseconds = newseconds * factor
            if newseconds > 0 {
                defaults.set(newseconds, forKey: "seconds")
                /*
                 if newseconds > defaults.double(forKey: "maxSeconds") {
                 defaults.set(newseconds, forKey: "maxSeconds")
                 } */
                defaults.synchronize()
                
            }
            
        }
    }
    
}
extension LevelManager {
    private var defaultWaitingTime: Double {
        return 10.0
    }
    private var increaseDecreasePercentage : Double {
        return 0.1
    }
    private var multiplyFactor : Double {
        return 3.0
    }
}
