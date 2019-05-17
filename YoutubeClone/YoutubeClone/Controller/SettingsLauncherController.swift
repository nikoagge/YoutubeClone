//
//  SettingsLauncher.swift
//  YoutubeClone
//
//  Created by Nikolas on 11/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import Foundation
import UIKit


class SettinsLauncherController: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    static let sharedInstance = SettinsLauncherController()
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        
        return cv
    }()
    
    let cellId = "cellId"
    
    //Datasource
    let settings: [Setting] = {
        
        return [Setting(forSettingNameEnum: .Settings, forImageName: "settings"), Setting(forSettingNameEnum: .TermsPrivacy, forImageName: "privacy"), Setting(forSettingNameEnum: .SendFeedback, forImageName: "feedback"), Setting(forSettingNameEnum: .Help, forImageName: "help"), Setting(forSettingNameEnum: .SwitchAccount, forImageName: "switch_account"), Setting(forSettingNameEnum: .Cancel, forImageName: "cancel")]
    }()
    
    let cellHeight: CGFloat = 50
    
    var homeController: HomeController?
    
    
    override init() {
        
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    @objc func showSettings() {
        
        //In order to show a blackView that captures the whole window, we write this:
        if let window = UIApplication.shared.keyWindow {
            
            //Set white value to 0 for completely black, and alpha value to 0.5 for transparency
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            //BlackView's default alpha value is equal to 1.
            blackView.alpha = 0
            blackView.frame = window.frame
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSimpleDismissSettingsLauncher)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            //Dynamically calculate height in order to show all cells at once and no need to scroll down.
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                
                //In order to animate collectionView I write following line.
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    
    @objc func handleSimpleDismissSettingsLauncher() {
        
        UIView.animate(withDuration: 0.5) {
            
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }
    }
    
    
    @objc func handleDismiss(forSetting setting: Setting) {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            
            //Here we have the actual dismissal code.
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed) in
            
            //In order to just dismiss settingsLauncher and navigate to new navigationController when tapping Cancel or in blank space of the view, write following line of code.
            if setting.name != .Cancel {
                
                self.homeController?.showViewControllerForSetting(forSetting: setting)
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return settings.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //Set width like this to have each cell extended from one side of collectionView to another. Height value is arbitrary.
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    
    //To reduce redundant space between cells.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let setting = settings[indexPath.item]
        handleDismiss(forSetting: setting)
    }
}
