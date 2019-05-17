//
//  SettingsCell.swift
//  YoutubeClone
//
//  Created by Nikolas on 11/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import UIKit


class SettingsCell: BaseCell {
    
    
    override var isHighlighted: Bool {
        
        didSet {
            
            backgroundColor = isHighlighted ? .darkGray : .white
            
            nameLabel.textColor = isHighlighted ? .white : .black
            
            //In order to have this effect must set iconImageView.image as .alwaysTemplate.
            iconImageView.tintColor = isHighlighted ? .white : .darkGray
        }
    }
    
    var setting: Setting? {
        
        didSet {
            
            nameLabel.text = setting?.name.rawValue
            
            guard let safelyUnwrappedImageName = setting?.imageName else { return }
            iconImageView.image = UIImage(named: safelyUnwrappedImageName)?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = .darkGray
        }
    }
    
    let nameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        
        return label
    }()
    
    let iconImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    
    override func setupViews() {
        
        super.setupViews()
    
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        //Extend horizontally from left to right boundaries of every cell with following line.
        addConstraintsWithFormat(withFormat: "H:|-8-[v0(30)]-8-[v1]|", forViews: iconImageView, nameLabel)
         //Extend vertically from bottom to top boundaries of every cell with following line.
        addConstraintsWithFormat(withFormat: "V:|[v0]|", forViews: nameLabel)
        //Can't align two views together vertically as I do it horizontally, so I write vertical constraints separately.
        addConstraintsWithFormat(withFormat: "V:[v0(30)]", forViews: iconImageView)
        
        //To align the two views vertically I write this
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: nameLabel, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
