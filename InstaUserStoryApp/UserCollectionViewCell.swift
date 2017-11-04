//
//  UserCollectionViewCell.swift
//  InstaUserStoryApp
//
//  Created by Adithya on 11/1/17.
//  Copyright © 2017 Adithya. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var UserNameLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        let gradient = CAGradientLayer()
        gradient.frame = self.containerView.bounds
        gradient.colors = [UIColor.init(red: 238/255, green: 42/255, blue: 123/255, alpha: 1.0).cgColor,UIColor.init(red: 249/255, green: 237/255, blue: 50/255, alpha: 1.0).cgColor]
        gradient.startPoint = CGPoint.init(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint.init(x:0.0, y: 1.0)
        self.containerView.layer.insertSublayer(gradient, at: 0)
    
        
    }
    
 // FF4BA4 255 75 164
}

