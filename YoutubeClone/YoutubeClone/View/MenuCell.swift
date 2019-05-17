//
//  MenuCell.swift
//  YoutubeClone
//
//  Created by Nikolas on 07/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import Foundation
import UIKit


class MenuCell: BaseCell {
    
    
    let imageView: UIImageView = {
        
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "home").withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(ofRed: 91, ofGreen: 14, ofBlue: 13)
        
        return iv
    }()
    
    override var isHighlighted: Bool {
        
        //Anytime a menuCell is selected, this bit of code is executed.
        didSet {
            
            imageView.tintColor = isHighlighted ? .white : .rgb(ofRed: 91, ofGreen: 14, ofBlue: 13)
        }
    }
    
    override var isSelected: Bool {
        
        didSet {
            
            imageView.tintColor = isSelected ? .white : .rgb(ofRed: 91, ofGreen: 14, ofBlue: 13)
        }
    }
    
    
    override func setupViews() {
        
        super.setupViews()
        
        addSubview(imageView)
        
        //Following two lines gives us the dimensions of the imageView.
        addConstraintsWithFormat(withFormat: "H:[v0(28)]", forViews: imageView)
        addConstraintsWithFormat(withFormat: "V:[v0(28)]", forViews: imageView)
        
        //With following two lines we center the imageView.
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
