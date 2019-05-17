//
//  MenuBarExtension.swift
//  YoutubeClone
//
//  Created by Nikolas on 07/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import Foundation
import UIKit


extension MenuBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuBarCellId, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = .rgb(ofRed: 91, ofGreen: 14, ofBlue: 13)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //I want to have 4 cells separated equally, thus is frame.width/4.
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let x = CGFloat(indexPath.item) * frame.width / 4
        horizontalBarLeftAnchorConstraint?.constant = x
        
        //In order to have a little animation while choosing some cell of menuBar.
        //Now we don't need the animation code because this job is done on HomeController's scrollViewDidScroll function.
//        UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseOut, animations: {
//
//            self.layoutIfNeeded()
//        }, completion: nil)
        
        homeController?.scrollToMenuIndex(atMenuIndex: indexPath.item)
    }
}
