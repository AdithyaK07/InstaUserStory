//
//  UserStoriesListViewController.swift
//  InstaUserStoryApp
//
//  Created by Adithya on 11/1/17.
//  Copyright © 2017 Adithya. All rights reserved.
//

import UIKit

class UserStoriesListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var userStoriesListView: UICollectionView!
    
    var usersStoriesArray: [UserModelClass]? = [UserModelClass]()
    
  
    //MARK:- View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Instagram User Story"
        self.createUsersWithAssets()
    }

    //MARK: - Collection DataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.usersStoriesArray?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserStoryCell",
                                                      for: indexPath) as! UserCollectionViewCell
        let user = self.usersStoriesArray![indexPath.item]
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
//        firstUser.statusAssets = [UIImage.init(named: "image1.jpg")!,UIImage.init(named: "image2.jpeg")!,UIImage.init(named: "image3.jpeg")!]
        firstUser.statusAssets = ["image1.jpg"]
        self.usersStoriesArray?.append(firstUser)
        let secondUser = UserModelClass.init(name: "secondUser", photo: UIImage.init(named: "secondUser.jpeg"))
//        secondUser.statusAssets = [UIImage.init(named: "image4.jpeg")!,UIImage.init(named: "image5.jpeg")!,UIImage.init(named: "image6.jpeg")!,UIImage.init(named: "image7.jpeg")!,UIImage.init(named: "image8.jpeg")!]
        secondUser.statusAssets = ["image4.jpeg","image5.jpeg","video1.mp4","video2.mp4","image6.jpeg"]
        self.usersStoriesArray?.append(secondUser)
        let thirdUser = UserModelClass.init(name: "thirdUser", photo: UIImage.init(named: "thirdUser.jpeg"))
//        thirdUser.statusAssets = [UIImage.init(named: "image9.jpg")!,UIImage.init(named: "image1.jpg")!,UIImage.init(named: "image5.jpeg")!,UIImage.init(named: "image8.jpeg")!]
        thirdUser.statusAssets = ["image9.jpg","video6.mp4","image2.jpeg","video4.mp4","image4.jpeg"]
        self.usersStoriesArray?.append(thirdUser)
        let fourthUser = UserModelClass.init(name: "fourthUser", photo: UIImage.init(named: "fourthUser.jpeg"))
//        fourthUser.statusAssets = [UIImage.init(named: "image9.jpg")!]
        fourthUser.statusAssets = ["video4.mp4","video10.mp4","video7.mp4"]
        self.usersStoriesArray?.append(fourthUser)
    
    }
}



//        let storyViewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "StoryViewController") as! StoryViewController
//        storyViewcontroller.asserts = self.usersStoriesArray![indexPath.item].statusAssets as! [String]
