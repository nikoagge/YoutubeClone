//
//  SafeJSONObject.swift
//  YoutubeClone
//
//  Created by Nikolas on 14/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import UIKit


class SafeJSONObject: NSObject {

    
    override func setValue(_ value: Any?, forKey key: String) {
        
        let uppercasedFirstCharacter = String(key.first!).uppercased()
        
        let range = key.startIndex...key.index(key.startIndex, offsetBy: 0)
        let selectorString = key.replacingCharacters(in: range, with: uppercasedFirstCharacter)
        
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        
        if !responds {
            
            return
        }
        
        super.setValue(value, forKey: key)
    }
    
    
    init(_ dictionary:[String: Any]) {
        
        super.init()
        
        setValuesForKeys(dictionary)
    }
}
