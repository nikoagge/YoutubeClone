//
//  BaseCell.swift
//  YoutubeClone
//
//  Created by Nikolas on 07/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import UIKit


class BaseCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        
        
    }
}
