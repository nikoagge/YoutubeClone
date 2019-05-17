//
//  ConstraintsExtension.swift
//  YoutubeClone
//
//  Created by Nikolas on 02/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import Foundation
import UIKit


extension UIView {
    
    
    func addConstraintsWithFormat(withFormat format: String, forViews views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            
            let key = "v\(index)"
            
            viewsDictionary[key] = view
            
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
