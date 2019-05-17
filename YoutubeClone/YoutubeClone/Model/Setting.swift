//
//  Setting.swift
//  YoutubeClone
//
//  Created by Nikolas on 11/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import UIKit


class Setting: NSObject {
    
    
    let name: SettingNameEnums
    let imageName: String
    
    
    init(forSettingNameEnum settingNameEnum: SettingNameEnums, forImageName imageName: String) {
        
        self.name = settingNameEnum
        self.imageName = imageName
    }
}
