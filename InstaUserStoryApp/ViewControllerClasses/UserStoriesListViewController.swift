//
//  UserStoriesListViewController.swift
//  InstaUserStoryApp
//
//  Created by Adithya on 11/1/17.
//  Copyright © 2017 Adithya. All rights reserved.
//

import UIKit

class UserStoriesListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{

    @IBOutlet weak var userStoriesListView: UICollectionView!

    var usersStoriesArray = [UserModelClass]()
    
  
    //MARK:- View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Instagram User Story"
        self.createUsersWithAssets()
    }

    //MARK: - Collection DataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.usersStoriesArray.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserStoryCell",
                                                      for: indexPath) as! UserCollectionViewCell
        let user = self.usersStoriesArray[indexPath.item]
        cell.profileImageView.image = user.photo
        cell.UserNameLabel.text = user.name
        
        return cell
    }
    
    //MARK:- CollectionView Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyMasterVC = self.storyboard?.instantiateViewController(withIdentifier: "masterVC") as! MasterViewController
        storyMasterVC.usersArray = self.usersStoriesArray
        storyMasterVC.index = indexPath.item
        self.present(storyMasterVC, animated: true, completion: nil)
 
    }

    //MARK:- Helper Methods
    func createUsersWithAssets() {
        let firstUser = UserModelClass.init(name: "firstUser", photo: UIImage.init(named: "firstUser.jpeg"))
        firstUser.statusAssets = ["image1.jpg","image5.jpeg"]
        self.usersStoriesArray.append(firstUser)
        let secondUser = UserModelClass.init(name: "secondUser", photo: UIImage.init(named: "secondUser.jpeg"))
        secondUser.statusAssets = ["image4.jpeg","image5.jpeg","video1.mp4","video2.mp4","image6.jpeg"]
        self.usersStoriesArray.append(secondUser)
        let thirdUser = UserModelClass.init(name: "thirdUser", photo: UIImage.init(named: "thirdUser.jpeg"))
        thirdUser.statusAssets = ["video6.mp4","image2.jpeg","video4.mp4","image4.jpeg"]
        self.usersStoriesArray.append(thirdUser)
        let fourthUser = UserModelClass.init(name: "fourthUser", photo: UIImage.init(named: "fourthUser.jpeg"))
        fourthUser.statusAssets = ["video4.mp4","video10.mp4","video7.mp4"]
        self.usersStoriesArray.append(fourthUser)
        
    }
}

