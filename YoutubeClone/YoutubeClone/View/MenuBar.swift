//
//  MenuBar.swift
//  YoutubeClone
//
//  Created by Nikolas on 07/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import UIKit


class MenuBar: UIView {

    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        //CollectionView comes with default background color as black. To change that we write this:
        cv.backgroundColor = .rgb(ofRed: 230, ofGreen: 32, ofBlue: 31)
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    
    let menuBarCellId = "menuBarCellId"
    let imageNames = ["home", "trending", "subscriptions", "account"]
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    var homeController: HomeController?
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubview(collectionView)
        addConstraintsWithFormat(withFormat: "H:|[v0]|", forViews: collectionView)
        addConstraintsWithFormat(withFormat: "V:|[v0]|", forViews: collectionView)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: menuBarCellId)
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: true, scrollPosition: [])
        
        setupHorizontalBar()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupHorizontalBar() {
        
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(horizontalBarView)
        
        //Old school frame way of doing things would be this:
        //horizontalBarView.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        
        //New school way of laying out our view.
        //Need x, y, width, height constraints.
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 8).isActive = true
    }
}
