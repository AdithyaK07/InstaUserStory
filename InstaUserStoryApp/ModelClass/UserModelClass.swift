//
//  UserModelClass.swift
//  InstaUserStoryApp
//
//  Created by Adithya on 11/1/17.
//  Copyright © 2017 Adithya. All rights reserved.
//

import UIKit

class UserModelClass: NSObject {
    var name:String
    var photo:UIImage? = UIImage.init(named: "defaultImage")
    var statusAssets:[Any]?
    
   
    init(name:String, photo:UIImage?) {
    self.name = name
        if photo != nil{
         self.photo = photo
        }
    }
}
