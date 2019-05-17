//
//  RGBColorExtension.swift
//  YoutubeClone
//
//  Created by Nikolas on 06/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import Foundation
import UIKit


extension UIColor {
    
    
    static func rgb(ofRed red: CGFloat, ofGreen green: CGFloat, ofBlue blue: CGFloat) -> UIColor {
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
