//
//  HomeVideoCollectionViewCell.swift
//  YoutubeClone
//
//  Created by Nikolas on 02/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import UIKit


class HomeVideoCollectionViewCell: BaseCell {

    
    var video: Video? {
        
        didSet {
            
            setupThumbnailImage()
            setupProfileImage()
            setupTitle()
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            
            guard let channelName = video?.channel?.name, let numberOfViews = video?.number_of_views, let numberOfViewsWithNumberFormatter = numberFormatter.string(from: numberOfViews) else { return }
            
            
            let subtitleText = "\(channelName) • \(numberOfViewsWithNumberFormatter) • 5 years ago"
            subtitleTextView.text = subtitleText
            
            //Measure title text
            guard let title = video?.title else { return }
            //First 16 is the horizontal gap between userProfileImageView and super view, 44 is pixel density of profileImageView, 8 is the gap between userProfileImageView and titleLabel and 16 the gap between the titleLabel and super view.
            let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            
            let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
            
            if estimatedRect.size.height > 20 {
                
                titleLabelHeightConstraint?.constant = 44
            } else {
                
                titleLabelHeightConstraint?.constant = 20
            }
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        
        let imageView = CustomImageView()
        imageView.image = #imageLiteral(resourceName: "taylor_swift_blank_space")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let separatorView: UIView = {
        
        let sepView = UIView()
        sepView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        return sepView
    }()
    
    let userProfileImageView: CustomImageView = {
        
        let imageView = CustomImageView()
        imageView.image = #imageLiteral(resourceName: "taylor_swift_profile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        label.numberOfLines = 2
        
        return label
    }()
    
    let subtitleTextView: UITextView = {
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO • 1.604.684.827 • 5 years"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = .lightGray
        
        return textView
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    
    override func setupViews() {
        
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraintsWithFormat(withFormat: "H:|-16-[v0]-16-|", forViews: thumbnailImageView)
        addConstraintsWithFormat(withFormat: "H:|[v0]|", forViews: separatorView)
        addConstraintsWithFormat(withFormat: "H:|-16-[v0(44)]", forViews: userProfileImageView)
        
        //The missing | from left means that it won't touch upper edge, and (1) means that it will be 1 pixel tall.
        addConstraintsWithFormat(withFormat: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", forViews: thumbnailImageView, userProfileImageView, separatorView)
        
        //Top constraint for titleLabel.
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        //Left constraint for titleLabel.
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //Right constraint for titleLabel.
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //Height constraint for titleLabel. Here in constant I put how many pixels tall want to make it.
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        guard let titleLabelHeightConstraint = titleLabelHeightConstraint else { return }
        addConstraint(titleLabelHeightConstraint)
        
        //Top constraint for subtitleTextView.
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        
        //Left constraint for subtitleTextView.
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //Right constraint for subtitleTextView.
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0))
        
        //Height for subtitleTextView.
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
    
    
    func setupThumbnailImage() {
        
        guard let thumbnailImageURL = video?.thumbnail_image_name else { return }
        
        thumbnailImageView.loadImageUsingURLString(forURLString: thumbnailImageURL)
    }
    
    
    func setupProfileImage() {
        
        guard let profileImageURL = video?.channel?.profile_image_name else { return }
        
        userProfileImageView.loadImageUsingURLString(forURLString: profileImageURL)
    }
    
    
    func setupTitle() {
        
        guard let videoTitle = video?.title else { return }
        
        self.titleLabel.text = videoTitle
    }
}
